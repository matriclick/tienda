# encoding: UTF-8
class StoreAdminController < ApplicationController
  before_filter :redirect_unless_store_admin, :generate_bread_crumbs
  
  def select_store
    @supplier_accounts = current_user.supplier_accounts
  end

  def products
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    add_breadcrumb "Productos de "+@supplier_account.fantasy_name, store_admin_products_path(public_url: params[:public_url])
    
    if !params[:code_q].nil?
      @code_search_text = params[:code_q]
      @search_text = 'Nombre o descripción del producto'      
      @dresses = @supplier_account.dresses.where('code like "%'+params[:code_q]+'%"').paginate(:page => params[:page]).order('created_at DESC')
    elsif !params[:q].nil?
      @code_search_text = 'Código del producto'
      @search_text = params[:q]
      @dresses = @supplier_account.dresses.where('introduction like "%'+params[:q]+'%" or description like "%'+params[:q]+'%"').paginate(:page => params[:page]).order('created_at DESC')
    else
      @code_search_text = 'Código del producto'
      @search_text = 'Nombre o descripción del producto'
      @dresses = @supplier_account.dresses.paginate(:page => params[:page]).order('created_at DESC')
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

    @purchases = Purchase.where('created_at >= ? and created_at <= ? and funds_received = ?', @from, @to, true)
    @purchased_products_data = @supplier_account.check_owned_products_purchased_from_purchases(@purchases)
    
    @paid = 0
    @debt = 0
    @purchased_products_data.each do |val|
      if val[:store_paid]
        @paid = @paid + val[:unit_cost]*val[:quantity] if !val[:unit_cost].nil? and !val[:quantity].nil?
      else
        @debt = @debt + val[:unit_cost]*val[:quantity] if !val[:unit_cost].nil? and !val[:quantity].nil?
      end
    end

  end

  def payments
    @supplier_account = SupplierAccount.find_by_public_url params[:public_url]
    add_breadcrumb "Pagos de "+@supplier_account.fantasy_name, store_admin_payments_path(public_url: params[:public_url])
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Tramanta", :root_path
    add_breadcrumb "Mis Tiendas", :store_admin_select_store_path
  end

end
