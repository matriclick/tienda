# encoding: UTF-8
require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/png_outputter'

class StoreAdminController < ApplicationController
  before_filter :redirect_unless_store_admin, :generate_bread_crumbs
  before_filter :check_order, only: [:products]

  def select_store
    @supplier_accounts = current_user.supplier_accounts
  end

  def products
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    add_breadcrumb "Productos de "+@supplier_account.fantasy_name, store_admin_products_path(public_url: params[:public_url])
    
    @dress_type_name = params[:dress_type]
    if @dress_type_name.blank? or @dress_type_name == "Todas las categorías"
      dresses_aux = @supplier_account.dresses
    else
      dt = DressType.find_by_name @dress_type_name
      dresses_aux = @supplier_account.dresses.joins(:dress_types).where('dress_types.id = ?', dt.id)
    end
    
    if !params[:code_q].nil?
      @code_q = params[:code_q]
      @code_search_text = params[:code_q]
      @search_text = 'Nombre o descripción del producto'
      dsz_id = @code_q[0..11].to_i
      dress_stock_size = DressStockSize.find dsz_id
      @dresses = dresses_aux.where('id = ?'+check_view, dress_stock_size.dress.id).paginate(:page => params[:page]).order(@order)
    elsif !params[:q].nil?
      @q = params[:q]
      @code_search_text = 'SKU del producto'
      @search_text = params[:q]
      @dresses = dresses_aux.where('introduction like "%'+params[:q]+'%" or description like "%'+params[:q]+'%"'+check_view).paginate(:page => params[:page]).order(@order)
    else
      @code_search_text = 'SKU del producto'
      @search_text = 'Nombre o descripción del producto'
      @dresses = dresses_aux.where('dresses.price like "%0%"'+check_view).paginate(:page => params[:page]).order(@order)
    end
  end

  def purchases
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_month
      @to = DateTime.now.utc.end_of_month
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    add_breadcrumb "Reportes", :store_admin_reports_path
    add_breadcrumb "Ventas de "+@supplier_account.fantasy_name, store_admin_purchases_path(public_url: params[:public_url])

    @purchases = Purchase.where('created_at >= ? and created_at <= ? and funds_received = ?', @from, @to, true).order('created_at DESC')
    @purchased_products_data = @supplier_account.check_owned_products_purchased_from_purchases(@purchases)
    
    @paid = 0
    @debt = 0
    @purchased_products_data.each do |val|
      unless val[:refunded]
        if val[:store_paid]
          @paid = @paid + val[:unit_cost]*val[:quantity] if !val[:unit_cost].nil? and !val[:quantity].nil?
        else
          @debt = @debt + val[:unit_cost]*val[:quantity] if !val[:unit_cost].nil? and !val[:quantity].nil?
        end
      end
    end
  end

  def payments
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_year
      @to = DateTime.now.utc.end_of_year
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @sa = SupplierAccount.find_by_public_url params[:public_url]
    add_breadcrumb "Reportes", :store_admin_reports_path
    add_breadcrumb "Pagos de "+@sa.fantasy_name, store_admin_payments_path(public_url: params[:public_url])
  end
  
  def users
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    add_breadcrumb "Usuarios de "+@supplier_account.fantasy_name, store_admin_users_path(public_url: params[:public_url])
    @users = @supplier_account.users
  end
  
  def add_user
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    user = User.where(:email => params[:user_email]).first
    if !user.nil?
      user.supplier_accounts << @supplier_account
      user.role_id = 2
      user.save
      redirect_to store_admin_users_path(public_url: params[:public_url]), notice: 'Usuario agregado exitosamente'
    else
      redirect_to store_admin_users_path(public_url: params[:public_url]), notice: 'Correo no registrado en Tramanta.com'
    end
  end
  
  def remove_user
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    user = User.find params[:user_id]
    if !user.nil?
      user.supplier_accounts.delete @supplier_account
      user.role_id = nil
      user.store_admin_privileges.delete StoreAdminPrivilege.all
      user.save
      redirect_to store_admin_users_path(public_url: params[:public_url]), notice: 'Usuario eliminado exitosamente'
    else
      redirect_to store_admin_users_path(public_url: params[:public_url]), notice: 'Correo no registrado en Tramanta.com'
    end
  end
  
  def reports
    add_breadcrumb "Reportes", :store_admin_reports_path
  end
  
  def point_of_sale
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    add_breadcrumb "Punto de venta de "+@supplier_account.fantasy_name, store_admin_point_of_sale_path(public_url: params[:public_url])
    @purchasable = params[:cart_id].blank? ? ShoppingCart.new : ShoppingCart.find(params[:cart_id])
    @price = @purchasable.price
  end
  
  def add_product_to_cart_from_barcode
    @purchasable = params[:cart_id].blank? ? ShoppingCart.create : ShoppingCart.find(params[:cart_id])
    # Formato de barcode: string_talla#string_color#slug_producto##
    barcode = params[:barcode]
    dsz_id = barcode[0..11].to_i
    dress_stock_size = DressStockSize.find dsz_id
    
    if current_user.supplier_accounts.include? dress_stock_size.dress.supplier_account
      if dress_stock_size.stock == 0
        redirect_to store_admin_point_of_sale_path(public_url: params[:public_url], cart_id: @purchasable.id), notice: 'Error: Producto Agotado en el Sistema'
      else
        shopping_cart_item = ShoppingCartItem.create(:purchasable_id => dress_stock_size.dress.id, :purchasable_type => 'Dress', :shopping_cart_id => @purchasable.id, :size => dress_stock_size.size.name, :color => dress_stock_size.color, :quantity => 1) 
        redirect_to store_admin_point_of_sale_path(public_url: params[:public_url], cart_id: @purchasable.id), notice: 'Producto Agregado'
      end
    else
      redirect_to root_path
    end
  end
  
  def remove_product_from_cart
    @purchasable = params[:cart_id].blank? ? ShoppingCart.create : ShoppingCart.find(params[:cart_id])
    shopping_cart_item = ShoppingCartItem.where('purchasable_id = ? and purchasable_type = "Dress" and shopping_cart_id = ?', params[:product_id], @purchasable.id).first
    @purchasable.shopping_cart_items.delete shopping_cart_item
    redirect_to store_admin_point_of_sale_path(public_url: params[:public_url], cart_id: @purchasable.id), notice: 'Producto eliminado'
  end
  
  def select_user_privileges
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    @user = User.find(params[:user_id])
  end
  
  def update_store_admin_privileges
    @user = User.find(params[:user_id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to store_admin_users_path(public_url: params[:public_url]), notice: 'Permisos del usuario actualizados' }
        format.json { head :ok }
      else
        format.html { redirect_to store_admin_users_path(public_url: params[:public_url]) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def generate_pos_purchase
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    @purchasable = ShoppingCart.find(params[:cart_id])
    pos_purchase = PosPurchase.create(user_id: current_user.id, email_buyer: params[:email_buyer], payment_method: params[:medio_pago], 
                                      shopping_cart_id: @purchasable.id, price: @purchasable.price, currency: 'CLP', supplier_account_id: @supplier_account.id)
    
    @purchasable.shopping_cart_items.each do |sci|
      size = Size.find_by_name(sci.size)
      dress_stock_size = DressStockSize.where('dress_id = ? and size_id = ? and color = ?', sci.purchasable_id, size.id, sci.color).first
      dress_stock_size.stock = dress_stock_size.stock - 1
      dress_stock_size.save
      dress_stock_size.dress.save
    end
    
    redirect_to store_admin_point_of_sale_path(public_url: params[:public_url]), notice: 'Venta registrada OK'
  end
  
  def barcode
    @dress = Dress.find_by_slug params[:slug]
    
    @dress.dress_stock_sizes.each do |dsz|
      @barcode_value = dsz.generate_barcode
      @full_path = "#{Rails.root}/public/system/barcodes/"+@dress.supplier_account.fantasy_name+'/'+dsz.size.name+'_'+dsz.color+'_'+@dress.id.to_s+"_barcode.png"  
      dir = File.dirname(@full_path)
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      barcode = Barby::EAN13.new(@barcode_value)
      File.open(@full_path, 'w') { |f| f.write barcode.to_png(:margin => 3, :height => 55) }
    end
    
    add_breadcrumb "Productos de "+@dress.supplier_account.fantasy_name, store_admin_products_path(public_url: @dress.supplier_account.public_url)
    add_breadcrumb @dress.introduction, dress_ver_path(:type => @dress.dress_type.name, :slug => @dress.slug)
    add_breadcrumb 'Códigos de Barra', store_admin_barcode_path(slug: @dress.slug)  
  end
  
  def reports_transactions
    add_breadcrumb "Reportes", :store_admin_reports_path
    add_breadcrumb "Transacciones", :store_admin_reports_transactions_path
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_day
      @to = DateTime.now.utc.end_of_day
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    @pos_purchases = PosPurchase.where('created_at >= ? and created_at <= ? and supplier_account_id = ?', @from, @to, @supplier_account.id).order 'created_at DESC'
    
    if params[:commit] == 'Descargar Reporte'
      respond_to do |format|
        format.html
        format.csv { send_data PosPurchase.to_csv(@from, @to, @supplier_account).encode("iso-8859-1"), 
                      :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename="+Time.now.localtime.strftime("%Y_%m_%d")+"_detalle_transacciones_"+@supplier_account.fantasy_name.gsub(' ','_').downcase+".csv" }
      end
    end
    
  end
  
  def reports_sales
    add_breadcrumb "Reportes", :store_admin_reports_path
    add_breadcrumb "Ventas", :store_admin_reports_sales_path
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_month
      @to = DateTime.now.utc.end_of_day
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    @view_with_graphs = true
    @pos_purchases = PosPurchase.where('pos_purchases.created_at >= ? and pos_purchases.created_at <= ?', @from, @to).order 'pos_purchases.created_at DESC'
  end
  
  def reports_inventory
    add_breadcrumb "Reportes", :store_admin_reports_path
    add_breadcrumb "Inventario", :store_admin_reports_inventory_path
    @view_with_graphs = true
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    available = DressStatus.find_by_name("Disponible")
    hidden = DressStatus.find_by_name("Oculto")
    @dresses = Dress.where('supplier_account_id = ? and (dress_status_id = ? or dress_status_id = ?)', @supplier_account.id, available.id, hidden.id)
    @dress_types = DressType.joins(:dresses).where('supplier_account_id = ? and (dress_status_id = ? or dress_status_id = ?)', @supplier_account.id, available.id, hidden.id)
    
    if params[:commit] == 'Descargar Reporte'
      respond_to do |format|
        format.html
        format.csv { send_data Dress.to_csv(@from, @to, @supplier_account).encode("iso-8859-1"), 
                      :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename="+Time.now.localtime.strftime("%Y_%m_%d")+"_inventario.csv" }
      end
    end
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Tramanta", :root_path
    add_breadcrumb "Mis Tiendas", :store_admin_select_store_path
  end
  
  def check_order
    @order_param = params[:order]
    if @order_param.nil? or @order_param == "Sin orden"
      @order = "position ASC, created_at DESC"
    else
      if @order_param == "Lo nuevo"
        @order = "created_at DESC"
      elsif @order_param == "Precio Menor a Mayor"
        @order = "price ASC"
      elsif @order_param == "Precio Mayor a Menor"
        @order = "price DESC"
      end
    end
  end
  
  def check_view
    @view_param = params[:view]
    sql = ''
    unless @view_param == "Ver todos"
      if @view_param == "Ver solo con stock" or @view_param.nil?
        @view_param = "Ver solo con stock" 
        sql = (' and dress_status_id = '+DressStatus.find_by_name('Disponible').id.to_s+' or dress_status_id = '+DressStatus.find_by_name('Oculto').id.to_s)
      elsif @view_param == "Ver solo agotados"
        sql = (' and dress_status_id = '+DressStatus.find_by_name('Vendido y Oculto').id.to_s+' or dress_status_id = '+DressStatus.find_by_name('Vendido').id.to_s)
      end
    end
    return sql
  end
        
end
