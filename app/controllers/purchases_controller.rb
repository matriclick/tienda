# encoding: UTF-8
class PurchasesController < ApplicationController  
  before_filter :redirect_unless_admin, :generate_bread_crumbs, :except => [:create, :show_for_user]
  before_filter :authenticate_user!, :only => [:show_for_user, :create]
    
  # GET /purchases
  # GET /purchases.json
  def index
    redirect_unless_privilege('Vestidos')
    
    if params[:product_q].blank? and params[:user_q].blank?
      if params[:from].nil? or params[:to].nil?
       @from = DateTime.now.utc.beginning_of_week
       @to = DateTime.now.utc.end_of_week
      else
       @from = Time.parse(params[:from]).utc.beginning_of_day
       @to = Time.parse(params[:to]).utc.end_of_day
      end
    else
      @from = Time.parse("2000-01-01").utc.beginning_of_year
      @to = Time.parse("2020-12-01").utc.end_of_year
    end
    
    if !params[:product_q].blank?
      @producto_search_text = params[:product_q]
      dresses = Dress.joins(:dress_types).where('dress_types.name like "%'+params[:product_q]+'%" or dresses.description like "%'+params[:product_q]+'%" or dresses.introduction like "%'+params[:product_q]+'%"').uniq
      query_sci = ''
      dresses.each_with_index do |d, i|
        if i == 0
          query_sci = 'purchasable_id = '+d.id.to_s
        else
          query_sci = 'purchasable_id = '+d.id.to_s+' or '+query_sci
        end
      end
      scis = ShoppingCartItem.where('purchasable_type = "Dress" and ('+query_sci+')') 
      query_p = ''
      scis.each_with_index do |sci, i|    
        if i == 0
          query_p = 'purchasable_id = '+sci.shopping_cart.id.to_s
        else
          query_p = 'purchasable_id = '+sci.shopping_cart.id.to_s+' or '+query_p
        end
      end
      @purchases = Purchase.where('purchasable_type = "ShoppingCart" and ('+query_p+')') 
    elsif !params[:user_q].blank?
      @user_search_text = params[:user_q]
      @purchases = Purchase.joins(:user).joins(:delivery_info).where('users.email like "%'+params[:user_q]+'%" or delivery_infos.name like "%'+params[:user_q]+'%"')
    else
      @purchases = Purchase
    end
    
    status = !params[:status].blank? ? params[:status] : 'finalizado'
    if status == 'all'
      @purchases = @purchases.where('purchases.created_at >= ? and purchases.created_at <= ?', @from, @to).order('purchases.created_at DESC')
    else
      @purchases = @purchases.where('purchases.created_at >= ? and purchases.created_at <= ? and status = ?', @from, @to, status).order('purchases.created_at DESC')    
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
      redirect_to user_profile_personalization_path
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
    
    if !@purchase.delivery_info.nil? and !@purchase.delivery_info.commune.dispatch_cost.nil?
      if !@site_configuration.free_shipping_from_price.blank? and @site_configuration.free_shipping_from_price < @object.price
        @purchase.delivery_cost = 0
      else
        @purchase.delivery_cost = @purchase.delivery_info.commune.dispatch_cost
      end
    else
      if !@site_configuration.free_shipping_from_price.blank? and @site_configuration.free_shipping_from_price < @object.price
        @purchase.delivery_cost = 0
      else
        @purchase.delivery_cost = 3200
      end
    end
    
    @purchase.purchasable_price = @object.price
  
    if !@purchase.quantity.blank? and !@purchase.delivery_cost.nil?
        @purchase.price = @purchase.purchasable_price * @purchase.quantity + @purchase.delivery_cost + @purchase.delivery_method.price
    elsif !@purchase.delivery_cost.blank?
        @purchase.price = @purchase.purchasable_price + @purchase.delivery_cost + @purchase.delivery_method.price
        @purchase.quantity = 1
    end
  
    if current_user.credit_amount > @purchase.price
			@purchase.credits_used = @purchase.price
		else
			@purchase.credits_used = current_user.credit_amount
		end
	
		@purchase.total_cost = 0
    if @purchase.purchasable_type == 'Dress'
      @purchase.total_cost = (@object.net_cost + @object.vat_cost)*@purchase.quantity
    else
      @purchase.purchasable.shopping_cart_items.each do |sci|
        sci.update_costs
        @purchase.total_cost = sci.total_cost + @purchase.total_cost
      end
    end
  
		@purchase.price = (@purchase.price - @purchase.credits_used).ceil
  
    #REGISTRO DE DATOS DE DESPACHO
    if !@purchase.delivery_info.nil?
      @purchase.dispatch_address = @purchase.delivery_info.street + ' ' + @purchase.delivery_info.number
      @purchase.dispatch_address = @purchase.dispatch_address +  ' - ' + @purchase.delivery_info.apartment if !@purchase.delivery_info.apartment.blank?
      @purchase.dispatch_address = @purchase.dispatch_address +  ', ' + @purchase.delivery_info.commune.name if !@purchase.delivery_info.commune.nil?
      @purchase.dispatch_address = @purchase.dispatch_address +  ', ' + @purchase.delivery_info.commune.region.name if !@purchase.delivery_info.commune.region.nil?
    end
  
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
    
    if @purchase.purchasable_type == 'Dress'
      @purchase.total_cost = (@object.net_cost + @object.vat_cost)*@purchase.quantity
    else
      @purchase.purchasable.shopping_cart_items.each do |sci|
        sci.update_costs
        @purchase.total_cost = sci.total_cost + @purchase.total_cost
      end
    end
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
      format.html { redirect_to purchases_url(:status => 'finalizado') }
      format.json { head :ok }
    end
  end
  
  private

  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
    add_breadcrumb "Lista de compras", purchases_path(:status => 'finalizado')
  end
      
end
