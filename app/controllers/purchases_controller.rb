# encoding: UTF-8
class PurchasesController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu, :except => [:create, :show_for_user]
  before_filter :authenticate_user!, :only => [:show_for_user]
  helper_method :sort_column, :sort_direction
    
  # GET /purchases
  # GET /purchases.json
  def index
    redirect_unless_privilege('Vestidos')
    
    if params[:from].nil? or params[:to].nil?
     @from = DateTime.now.beginning_of_year
     @to = DateTime.now.end_of_year
    else
     @from = Time.parse(params[:from])
     @to = Time.parse(params[:to])
    end
    
    status = !params[:status].nil? ? params[:status] : 'all'
    
    if status == 'all'
      @purchases = Purchase.where('created_at >= ? and created_at <= ?', @from, @to)      
    else
      @purchases = Purchase.where('created_at >= ? and created_at <= ? and status = ?', @from, @to, status)      
    end
     
    sort = sort_column
    order = sort_direction
    
    if sort == 'store'
      order == 'desc' ? @purchases.sort_by! {|u| u.purchasable.supplier_account.fantasy_name } : @purchases.sort_by! {|u| u.purchasable.supplier_account.fantasy_name }.reverse!
    elsif sort == 'user'
      order == 'desc' ? @purchases.sort_by! {|u| u.user.email } : @purchases.sort_by! {|u| u.user.email }.reverse!      
    else
      @purchases = @purchases.order(sort + " " + sort_direction)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchases }
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    redirect_unless_privilege('Vestidos')
    
    @purchase = Purchase.find(params[:id])
    @purchasable = eval(@purchase.purchasable_type + '.find ' + @purchase.purchasable_id.to_s)
    
    if !@purchase.quantity.blank?
      @subtotal = @purchasable.price * @purchase.quantity
    else
      @subtotal = @purchasable.price
    end
  end
  
  def show_for_user
    add_breadcrumb 'Tu cuenta', user_profile_personalization_path
    @purchase = Purchase.find(params[:id])
    @purchasable = eval(@purchase.purchasable_type + '.find ' + @purchase.purchasable_id.to_s)
    
    if !@purchase.quantity.blank?
      @subtotal = @purchasable.price * @purchase.quantity
    else
      @subtotal = @purchasable.price
    end

    if @purchase.user != current_user
      redirect_to edit_user_registration_path
    end
  end

  # GET /purchases/new
  # GET /purchases/new.json
  def new
    redirect_unless_privilege('Finanzas')
    
    @purchase = Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase }
    end
  end

  # GET /purchases/1/edit
  def edit
    redirect_unless_privilege('Finanzas')
    
    @purchase = Purchase.find(params[:id])
  end
  
  def refund_credit
    @purchase = Purchase.find(params[:id])   
  end
  
  def generate_refund_credit
    #REFUND
    @purchase = Purchase.find(params[:id])
    expiration_date = DateTime.now + 3.month
    @credit = Credit.create(:purchase_id => @purchase.id, :value => @purchase.price, 
                :user_id => @purchase.user_id, :formula => '@purchase.price', :expiration_date => expiration_date, :active => true)
    
    @purchase.update_attributes(:status => 'devuelto_creditos')
    
    #REDIRET
    respond_to do |format|
        format.html { redirect_to purchases_path(status: 'devuelto_creditos') }
    end
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(params[:purchase])
    @object = eval(@purchase.purchasable_type + '.find ' + @purchase.purchasable_id.to_s)
    
    @purchase.transfer_type = params[:payment][:option]
    @purchase.delivery_method = DeliveryMethod.find_by_name params[:delivery][:option]
    @purchase.delivery_method_cost = @purchase.delivery_method.price
    @purchase.delivery_cost = @purchase.delivery_info.commune.dispatch_cost if !@purchase.delivery_info.nil?
    @purchase.purchasable_price = @object.price
    
    if !@purchase.quantity.blank? and !@purchase.delivery_cost.nil?
        @purchase.price = @purchase.purchasable_price * @purchase.quantity + @purchase.delivery_cost + @purchase.delivery_method.price
    elsif !@purchase.delivery_cost.nil?
        @purchase.price = @purchase.purchasable_price + @purchase.delivery_cost + @purchase.delivery_method.price
        @purchase.quantity = 1
    end
    
    if current_user.credit_amount > @purchase.price
			@purchase.credits_used = @purchase.price
		else
			@purchase.credits_used = current_user.credit_amount
		end
				
		@purchase.price = (@purchase.price - @purchase.credits_used).ceil
    
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to buy_confirm_path(:purchase_id => @purchase) }
        format.json { render json: @purchase, status: :created, location: @purchase }
      else
        format.html { redirect_to buy_details_path(:purchasable_id => @purchase.purchasable_id.to_s, :purchasable_type => @purchase.purchasable_type), notice: 'Debes completar todos los campos y aceptar los términos y condiciones.<br />Recuerda agregar la dirección de despacho si es requerida.<br />Debes elegir una talla y la cantidad no debe superar la disponibilidad.<br />' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # PUT /purchases/1
  # PUT /purchases/1.json
  def update
    @purchase = Purchase.find(params[:id])
    @object = eval(@purchase.purchasable_type + '.find ' + @purchase.purchasable_id.to_s)
    
    session[:matriclick_purchase_price] = @purchase.price
    
    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        format.html { redirect_to buy_confirm_path(:purchase_id => @purchase) }
        format.json { head :ok }
      else
        format.html { redirect_to buy_details_path(:purchasable_id => @purchase.purchasable_id.to_s, :purchasable_type => @purchase.purchasable_type), notice: 'Debes completar todos los campos y aceptar los términos y condiciones.<br />Recuerda agregar la dirección de despacho si es requerida.<br />Debes elegir una talla y la cantidad no debe superar la disponibilidad.<br />' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    redirect_unless_privilege('Finanzas')
    
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :ok }
    end
  end
  
  private

  def sort_column
    %w[created_at store purchasable_type user price].include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
    
end
