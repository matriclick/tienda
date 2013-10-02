# encoding: UTF-8
class AdministrationController < ApplicationController
  autocomplete :user, :email
  before_filter :redirect_unless_admin, :generate_bread_crumbs
  
  def configuration
    @conf = SiteConfiguration.find_or_create_by_id(1)
    add_breadcrumb "Configuración general del sitio", :administration_configuration_path
  end
  
  def save_configuration
    @conf = SiteConfiguration.find(params[:id])

    respond_to do |format|
      if @conf.update_attributes(params[:site_configuration])
        format.html { redirect_to administration_configuration_path, notice: 'Configuración Actualizada' }
        format.json { head :ok }
      else
        format.html { render action: "configuration", notice: @conf.errors }
        format.json { render json: @conf.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def new_store_payment
    add_breadcrumb "Nuevo pago a Tienda", :administration_new_store_payment_path
    @store_payment = StorePayment.new
    @sci_ids = params[:sci_ids]
    @sa = ShoppingCartItem.find(@sci_ids.first).purchasable.supplier_account
  end
  
  #PUT
  def create_store_payment
    @store_payment = StorePayment.new(params[:store_payment])
    @sci_ids = params[:sci_ids]
    
    respond_to do |format|
      if @store_payment.save
        @sci_ids.each do |id|
          sci = ShoppingCartItem.find(id)
          sci.update_attribute(:store_paid, true)
          @store_payment.shopping_cart_items << sci
          @store_payment.save
          sci.shopping_cart.update_purchase_paid_status()
        end
        
        format.html { redirect_to reports_products_payments_path, notice: 'Pago OK' }
      else
        format.html { redirect_to reports_products_payments_path, notice: 'Error al generar el Pago' }
      end
    end
    
  end
  
  #PUT
  def assign_user_to_supplier
    @u_ids = params[:user_ids]
    @sa = SupplierAccount.find params[:sa_id]
    @sa.users.clear
    if !@u_ids.blank?
      @u_ids.each do |u_id|
        user = User.find u_id
        @sa.users << user
      end
    end
    @sa.save
    
    redirect_to administration_suppliers_list_path(:filter => "Active")
  end
  
  def add_user_to_supplier
    add_breadcrumb "Lista de Tiendas", administration_suppliers_list_path(:filter => "Active")
    add_breadcrumb "Agregar Administrador", administration_add_user_to_supplier_path(:sa_id => params[:sa_id])
    @users = User.where('role_id = ? or role_id = ?', 1, 2)
    @supplier_account = SupplierAccount.find params[:sa_id]
  end
    
  def edit_purchase
    redirect_unless_privilege('Finanzas')
    @purchase = Purchase.find(params[:id])
    @p_user_email = @purchase.user.email
  end
  
  def update_purchase
    redirect_unless_privilege('Finanzas')
    @purchase = Purchase.find(params[:id])
    user = User.find_by_email(params[:user_email])
    @purchase.user = user if !user.nil?

    refunded_sci_ids = params[:refund_shopping_cart_items]
    
    if !refunded_sci_ids.nil?
      refunded_sci_ids.each do |sci_id|
        sci = ShoppingCartItem.find sci_id
        sci.refunded = true
        sci.save
      end
    end
    
    respond_to do |format|
      if !user.nil? and @purchase.update_attributes(params[:purchase])
        if !@purchase.logistic_provider.nil? and params[:commit] == 'Actualizar y enviar correo'
          UserMailer.send_tracking_info(@purchase).deliver
        end
        format.html { redirect_to purchases_path(:status => 'finalizado') }
        format.json { head :ok }
      else
        format.html { redirect_to administration_edit_purchase_path(@purchase), notice: 'Errores' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def mailing_tools
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.yesterday
      @to = DateTime.now
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @send = params[:send]
    @users = User.get_all_with_tag
    @dresses = Dress.get_all_with_tag(@from, @to)
    #mail_infos tiene un hash { user_id => [dress_id] }
    @mail_infos = Mailing.get_personalized_mailing_information(@users, @dresses)
    
  end
  
  def mailing_sent
    @from = Time.parse(params[:from])
    @to = Time.parse(params[:to])
    
    @send = params[:send]
    @users = User.get_all_with_tag
    @dresses = Dress.get_all_with_tag(@from, @to)
    
    #mail_infos tiene un hash { user_id => [dress_id] }
    @mail_infos = Mailing.get_personalized_mailing_information(@users, @dresses)
    
    Mailing.create(:date_sent => DateTime.now, :users_sent => @mail_infos.size, :dresses_start_date => @from.strftime("%Y-%m-%d"), :dresses_end_date => @to.strftime("%Y-%m-%d"))
    @mail_infos.each do |user_id, dresses_id|
      if dresses_id.size > 0
        MassiveMailer.send_personalized_email(user_id, dresses_id).deliver
      end
    end
    redirect_to mailings_path
  end
    
  # GET
  def index
    if !current_user.matriclicker.nil?
      @matriclicker = current_user.matriclicker
    else 
      redirect_to root_path
    end
  end
    
  # GET
  def suppliers_list
    add_breadcrumb "Lista de tiendas", :administration_suppliers_list_path
    
    redirect_unless_privilege('Proveedores')
    
    @search_term = params[:q]
    @filter = params[:filter]
    @type = !params[:type].nil? ? params[:type] : 'all'
    
    if @type == 'all'    
      if (@search_term.nil? or @search_term.empty?) and (@filter.nil? or @filter.empty?)
        @suppliers = Supplier.order('created_at DESC').limit 20
      elsif !(@search_term.nil? or @search_term.empty?)
        @suppliers = Supplier.joins(:supplier_account => :supplier_account_type).
        where('supplier_accounts.fantasy_name like "%'+@search_term+'%" or supplier_account_types.name like "%'+@search_term+'%"');
      else
        @suppliers = Supplier.all
      end
    else
        sa_type = SupplierAccountType.find_by_name('Regular')
        
        @suppliers = Supplier.joins(:supplier_account => :supplier_account_type).
        where('supplier_account_types.id <> ?', sa_type.id)
    end
  end
  
	# GET
  #Edita el perfil del proveedor (Está anidado a /suppliers/:id/supplier_account/edit)
  def edit_supplier_account
    add_breadcrumb "Lista de tiendas", :administration_suppliers_list_path
    add_breadcrumb "Editar información", :administration_edit_supplier_account_path
    redirect_unless_privilege('Proveedores')
  	@supplier_account = SupplierAccount.find params[:supplier_account_id]
  end
  
  def reset_supplier_password
    add_breadcrumb "Lista de tiendas", :administration_suppliers_list_path
    add_breadcrumb "Nueva clave", :administration_reset_supplier_password_path
    redirect_unless_privilege('Proveedores')
    @supplier_account = SupplierAccount.find params[:supplier_account_id]
    @token = Time.now.to_s
    @supplier_account.supplier.update_attribute :reset_password_token, @token
    @supplier_account.supplier.update_attribute :reset_password_sent_at, Time.now
  end

	# PUT
  def update_supplier_account
    redirect_unless_privilege('Proveedores')
  	@supplier_account = SupplierAccount.find params[:id]
  	
  	respond_to do |format|
  		if @supplier_account.update_attributes(params[:supplier_account], :validate => false)
  			format.html { redirect_to administration_suppliers_list_path }
  		else
		    @industry_category_types = IndustryCategoryType.all
  			format.html { render action: 'edit_supplier_account'}
  			format.json { render json: @supplier_account.errors, status: :unprocessable_entity }
  		end
  	end
  end
  
	# DELETE
  def destroy_supplier
    redirect_unless_privilege('Proveedores')
  	@supplier = Supplier.find params[:id]
  	@supplier.destroy
  	
  	respond_to do |format|
  			format.html { redirect_to action: 'suppliers_list'}
  	end
  end

  def edit_dispatch_costs
    redirect_unless_privilege('Vestidos')
    
    @regions = []
    @regions << Region.find_by_name('RM - Metropolitana')
    @regions = @regions + Region.all
    @regions = @regions.uniq
  end

  def update_dispatch_costs
    redirect_unless_privilege('Vestidos')
    
    @communes = Commune.update(params[:communes].keys, params[:communes].values).reject { |commune| commune.errors.empty? }
    @regions = Region.update(params[:regions].keys, params[:regions].values).reject { |region| region.errors.empty? }
    
    if @communes.empty? and @regions.empty?
      redirect_to administration_edit_dispatch_costs_path
    else
      render :action => "edit_dispatch_costs"
    end
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
  end

end
