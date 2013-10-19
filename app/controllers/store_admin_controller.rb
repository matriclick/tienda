# encoding: UTF-8
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
      @dresses = dresses_aux.where('code like "%'+params[:code_q]+'%"'+check_view).paginate(:page => params[:page]).order(@order)
    elsif !params[:q].nil?
      @q = params[:q]
      @code_search_text = 'Código del producto'
      @search_text = params[:q]
      @dresses = dresses_aux.where('introduction like "%'+params[:q]+'%" or description like "%'+params[:q]+'%"'+check_view).paginate(:page => params[:page]).order(@order)
    else
      @code_search_text = 'Código del producto'
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
    add_breadcrumb "Pagos de "+@sa.fantasy_name, store_admin_payments_path(public_url: params[:public_url])
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Tramanta", :root_path
    add_breadcrumb "Mis Tiendas", :store_admin_select_store_path
  end
  
  def check_order
    @order_param = params[:order]
    if @order_param.nil? or @order_param == "- Orden -"
      if action_name == 'new_arrivals'
        @order = "created_at DESC"
      else
        @order = "position ASC, created_at DESC"
      end
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
    unless @view_param.nil? or @view_param == "Ver todos"
      if @view_param == "Ver solo con stock"
        sql = (' and dress_status_id = '+DressStatus.find_by_name('Disponible').id.to_s+' or dress_status_id = '+DressStatus.find_by_name('Oculto').id.to_s)
      elsif @view_param == "Ver solo agotados"
        sql = (' and dress_status_id = '+DressStatus.find_by_name('Vendido y Oculto').id.to_s+' or dress_status_id = '+DressStatus.find_by_name('Vendido').id.to_s)
      end
    end
    return sql
  end
    
end
