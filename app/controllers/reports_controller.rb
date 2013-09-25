# encoding: UTF-8
class ReportsController < ApplicationController
  before_filter :redirect_unless_admin, :generate_bread_crumbs
  before_filter { redirect_unless_privilege('Reportes') }
  helper_method :sort_column, :sort_direction
  
  def store_payments
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_year
      @to = DateTime.now.utc.end_of_year
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @supplier_accounts = SupplierAccount.approved
  end
  
  def sales_by_category
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_year
      @to = DateTime.now.utc.end_of_day
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @categories = DressType.all
    @statuses = DressStatus.all
    
  end
  
  def sales_by_store
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_day
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @stores = SupplierAccount.all
    
  end
  
  def products_in_wish_list
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_day
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    @wlis = DressesUsersWishList.select("dress_id, count(user_id) as count").where('created_at >= ? and created_at <= ?', @from, @to).group("dress_id")
    
    @wli_sum = 0
    @wlis.map { |wli| @wli_sum = @wli_sum + wli.count }
    
  end
  
  def products_payments
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_month
      @to = DateTime.now.utc.end_of_month
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @supplier_accounts = SupplierAccount.approved

    @purchases = Purchase.where('created_at >= ? and created_at <= ? and funds_received = ?', @from, @to, true)
    
  end
    
  def sales_dashboard
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end

    @days_month = Time.days_in_month(Time.now.month)
    @day_today = Time.now.day
    @factor = @days_month.to_f/@day_today

    @c_sum_month = Purchase.sum(:total_cost, :conditions => ['store_paid = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', DateTime.now.utc.beginning_of_month, DateTime.now.utc.end_of_month])
    @p_sum_month = Purchase.sum(:price, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', DateTime.now.utc.beginning_of_month, DateTime.now.utc.end_of_month])
    @r_sum_month = Purchase.sum(:refund_value, :conditions => ['refunded = ? and status = ? and refund_date >= ? and refund_date <= ?', true, 'finalizado', DateTime.now.utc.beginning_of_month, DateTime.now.utc.end_of_month])

    @c_sum = Purchase.sum(:total_cost, :conditions => ['store_paid = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', @from, @to])    
    @p_sum = Purchase.sum(:price, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', @from, @to])
    @r_sum = Purchase.sum(:refund_value, :conditions => ['refunded = ? and status = ? and refund_date >= ? and refund_date <= ?', true, 'finalizado', @from, @to])
    
    @count_paid_pur = Purchase.count(:conditions => ['store_paid = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', @from, @to])
    @count = Purchase.count(:conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', @from, @to])
    @prod_count = 0
    Purchase.where('funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', @from, @to).each do |p|
      if p.purchasable_type == 'Dress'
        @prod_count = 1 + @prod_count
      else
        @prod_count = p.purchasable.shopping_cart_items.size + @prod_count
      end
    end
  end
  
  def salestool
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @llamada = ChallengeActivityType.find_by_name("Llamada")
    @reunion = ChallengeActivityType.find_by_name("Reunion")
    @matriclickers = Matriclicker.active
  end
  
  def users
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
  end
  
  def dresses
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @wedding_type = DressType.find_by_name("vestidos-novia") 
    @party_type = DressType.find_by_name("vestidos-fiesta")
    @bridesmaid_type = DressType.find_by_name("vestidos-madrina")
  end
    
  def suppliers
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @industry_categories = IndustryCategory.all.joins(:countries).where("countries.id = ?", session[:country].id).sort_by {|ic| -SupplierAccount.from_industry(ic).joins(:conversations).approved.count }
  end
  
  def dresses_details
   if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    if params[:dress_type_id].nil?
      @dresses = Dress.joins(:dress_requests).where('dress_requests.created_at >= ? and dress_requests.created_at <= ?', @from, @to)
                  .uniq.sort_by {|dr| -dr.dress_requests.count }
    else
      @dress_type = DressType.find params[:dress_type_id]
      @dresses = Dress.joins(:dress_requests).where('dress_requests.created_at >= ? and dress_requests.created_at <= ?', @from, @to)
                  .joins(:dress_types).where(:dress_types => { id: @dress_type.id }).uniq.sort_by {|dr| -dr.dress_requests.count }
    end
  end
  
  def purchases
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
  end
     
  private

  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
  end
  
  def sort_column
    %w[conversations_count wedding_date last_conversation email].include?(params[:sort]) ? params[:sort] : "conversations_count"
  end

  def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
    
end
