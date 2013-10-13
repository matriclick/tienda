# encoding: UTF-8
class ReportsController < ApplicationController
  before_filter :redirect_unless_admin, :generate_bread_crumbs
  before_filter { redirect_unless_privilege('Reportes') }
  
  def wbr
    add_breadcrumb "WBR", :reports_wbr_path
    if params[:from].nil? or params[:to].nil?
      @from = (DateTime.now.utc - 6.week).beginning_of_week
      @to = DateTime.now.utc.end_of_day
    else
      @from = Time.parse(params[:from]).utc.beginning_of_week
      @to = Time.parse(params[:to]).utc.end_of_week
    end
    
    @wbr_data = Hash.new
    #Semana Inicio
    @init_week = @from.strftime("%W").to_i + 1
    @init_year = @from.strftime("%Y").to_i
    #Semana Fin
    @end_week = @to.strftime("%W").to_i + 1
    @end_year = @to.strftime("%Y").to_i

    @colspan = ((@to - @from) / 1.week).round + 2
    
    (@init_year..@end_year).each do |year|    
      (@init_week..@end_week).each do |week|
        monday_week = (Date.commercial(year, week)).beginning_of_day #Lunes de la semana week año year
        sunday_week = (Date.commercial(year, week + 1) - 1.day).end_of_day
        puts monday_week
        puts sunday_week
        
        #Total recibido
        price_week = Purchase.sum(:price, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', monday_week, sunday_week])  
        #Créditos usados
        credits_week = Purchase.sum(:credits_used, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', monday_week, sunday_week])  
        #Despachos pagados Cliente
        dispatch_income_week = Purchase.sum(:delivery_cost, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', monday_week, sunday_week])  
        #Despachos pagados Tramanta
        dispatch_cost_week = Purchase.sum(:actual_delivery_cost, :conditions => ['funds_received = ? and status = ? and delivery_date >= ? and delivery_date <= ?', true, 'finalizado', monday_week, sunday_week])  
        #Total Vendido (Recibido + créditod - despachos)
        sales_week = price_week + credits_week - dispatch_income_week
        #Costo Productos sin devoluciones
        cost_week = Purchase.sum(:total_cost, :conditions => ['funds_received = ? and status = ? and (refunded = ? or refunded is null) and created_at >= ? and created_at <= ?', true, 'finalizado', false, monday_week, sunday_week])        
        #Costo Productos con devoluciones
        cost_week_w_refund = Purchase.sum(:total_cost, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', monday_week, sunday_week])        
        #Devoluciones
        refunds_week = Purchase.sum(:refund_value, :conditions => ['funds_received = ? and refunded = ? and status = ? and refund_date >= ? and refund_date <= ?', true, true, 'finalizado', monday_week, sunday_week])
        #Margin
        margin_week = 100*(1 - cost_week_w_refund.to_f / (sales_week.to_f*0.81))
        #Revenue
        revenue_week = sales_week - cost_week/0.81 + dispatch_income_week - dispatch_cost_week - credits_week - refunds_week
        #Purchases
        purchases = Purchase.where('funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', monday_week, sunday_week)  
        purchases_week = purchases.size
        #Products and Cash In per Category
        categories_data = Hash.new
        prod_week = 0
        purchases.each do |p|
          if p.purchasable_type == 'Dress'
            prod_week = 1 + prod_week
            if categories_data[p.purchasable.dress_type.name].nil?
              categories_data[p.purchasable.dress_type.name] = { price_week: p.price }
            else 
              categories_data[p.purchasable.dress_type.name][:price_week] = categories_data[p.purchasable.dress_type.name][:price_week] + p.price
            end
          else
            prod_week = p.purchasable.shopping_cart_items.size + prod_week
            p.purchasable.shopping_cart_items.each do |sci|
              if categories_data[sci.purchasable.dress_type.name].nil?
                categories_data[sci.purchasable.dress_type.name] = { price_week: sci.price }
              else 
                categories_data[sci.purchasable.dress_type.name][:price_week] = categories_data[sci.purchasable.dress_type.name][:price_week] + sci.price
              end
            end
          end
        end
        #Tiendas con vestidos disponibles para vender
        supplier_accounts = SupplierAccount.where('created_at >= ? and created_at <= ?', monday_week, sunday_week)  
        disp = DressStatus.find_by_name("Disponible").id
        stores_week = 0
        supplier_accounts.each do |sa|
          stores_week = stores_week + 1 if sa.dresses.where(dress_status_id: disp).size > 0
        end
        
        #Productos creados
        vestidos = DressType.where('name like "%vestidos-fiesta%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
			  pantalones = DressType.where('name like "%ropa-de-mujer-pantalones%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
        tops = DressType.where('name like "%ropa-de-mujer-tops%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
			  abrigados = DressType.where('name like "%ropa-de-mujer-abrigados%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
			  chaquetas = DressType.where('name like "%ropa-de-mujer-chaquetas%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
			  polleras = DressType.where('name like "%ropa-de-mujer-polleras%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
			  interior = DressType.where('name like "%ropa-interior%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
			  zapatos = DressType.where('name like "%zapatos%"').first.dresses.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
        new_products = Dress.where('dresses.created_at >= ? and dresses.created_at <= ?', monday_week, sunday_week).size
        #Usuarios
        new_users = User.where('created_at >= ? and created_at <= ?', monday_week, sunday_week).size
        #Suscriptores
        new_subscribers = Subscriber.where('created_at >= ? and created_at <= ?', monday_week, sunday_week).size        
        #Información en WbrData
        wbr_datum = WbrDatum.where(:year => year, :week => week).first
        unless wbr_datum.nil?
          visits = wbr_datum.webpage_visits
          fb_followers = wbr_datum.fb_followers
          newsletters_sent = wbr_datum.newsletters_sent
        end
        
        #Agrego la información
        @wbr_data[(week.to_s+' - '+year.to_s)] = 
          { price_week: price_week, credits_week: credits_week, dispatch_income_week: dispatch_income_week, dispatch_cost_week: dispatch_cost_week, 
            sales_week: sales_week, cost_week: cost_week, revenue_week: revenue_week, refunds_week: refunds_week, margin_week: margin_week, 
            purchases_week: purchases_week, prod_week: prod_week, stores_week: stores_week, vestidos: vestidos, pantalones: pantalones, tops: tops, 
            abrigados: abrigados, chaquetas: chaquetas, polleras: polleras, interior: interior, zapatos: zapatos, new_products: new_products,
            new_users: new_users, new_subscribers: new_subscribers, visits: visits, fb_followers: fb_followers, newsletters_sent: newsletters_sent,
            categories_data: categories_data }
      end
    end
    
    if params[:commit] == 'Descargar Resultados'
      respond_to do |format|
        format.html
        format.csv { send_data export_wbr(@wbr_data,@init_year,@end_year,@init_week,@end_week).encode("iso-8859-1"), 
                      :type => 'text/csv; charset=iso-8859-1; header=present', 
                      :disposition => "attachment; filename=wbr_"+@init_week.to_s+"_"+@init_year.to_s+"_a_"+@end_week.to_s+"_"+@end_year.to_s+".csv" }
      end
    end
    
  end
  
  def credits
    add_breadcrumb "Créditos", :reports_credits_path
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_year
      @to = DateTime.now.utc.end_of_year
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    if params[:commit] == 'Descargar Reporte'
      respond_to do |format|
        format.html
        format.csv { send_data Credit.to_csv(@from, @to) }
      end
    end
    @credits = Credit.where('created_at >= ? and created_at <= ?', @from, @to).order 'created_at DESC'
        
  end
  
  def purchases_to_be_delivered
    add_breadcrumb "Productos por despachar", :reports_purchases_to_be_delivered_path
    redirect_unless_privilege('Vestidos')
  
    @purchases = Purchase.where('logistic_provider_id is null and funds_received = true').order('purchases.created_at DESC')
  
  end
  
  def store_payments
    add_breadcrumb "Pagos realizados a tiendas", :reports_store_payments_path
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
    add_breadcrumb "Ventas por categoría", :reports_sales_by_category_path
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
    add_breadcrumb "Ventas por tienda", :reports_sales_by_store_path
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
    add_breadcrumb "Productos en Wish List", :reports_products_in_wish_list_path
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
    add_breadcrumb "Pago a tiendas", :reports_products_payments_path
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_month
      @to = DateTime.now.utc.end_of_month
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
    @supplier_accounts = SupplierAccount.all
    @purchases = Purchase.where('created_at >= ? and created_at <= ? and funds_received = ?', @from, @to, true)
    
  end
  
  def sales_dashboard
    add_breadcrumb "Reporte de Ventas", :reports_sales_dashboard_path
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

    @c_sum_month = Purchase.sum(:total_cost, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', DateTime.now.utc.beginning_of_month, DateTime.now.utc.end_of_month])
    @p_sum_month = Purchase.sum(:price, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', DateTime.now.utc.beginning_of_month, DateTime.now.utc.end_of_month])
    @r_sum_month = Purchase.sum(:refund_value, :conditions => ['funds_received = ? and refunded = ? and status = ? and refund_date >= ? and refund_date <= ?', true, true, 'finalizado', DateTime.now.utc.beginning_of_month, DateTime.now.utc.end_of_month])

    @c_sum = Purchase.sum(:total_cost, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', @from, @to])    
    @p_sum = Purchase.sum(:price, :conditions => ['funds_received = ? and status = ? and created_at >= ? and created_at <= ?', true, 'finalizado', @from, @to])
    @r_sum = Purchase.sum(:refund_value, :conditions => ['funds_received = ? and refunded = ? and status = ? and refund_date >= ? and refund_date <= ?', true, true, 'finalizado', @from, @to])
    
    @count_paid_pur = Purchase.count(:conditions => ['funds_received = ? and store_paid = ? and status = ? and created_at >= ? and created_at <= ?', true, true, 'finalizado', @from, @to])
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
  
  def users
    add_breadcrumb "Reporte de Usuarios", :reports_users_path
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
          
    if params[:commit] == 'Descargar Reporte de Usuarios'
      respond_to do |format|
        format.html
        format.csv { send_data User.to_csv(@from, @to).encode("iso-8859-1"), 
                      :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=usuarios.csv" }
      end
    end

    if params[:commit] == 'Descargar Reporte de Suscriptores'
      respond_to do |format|
        format.html
        format.csv { send_data Subscriber.to_csv(@from, @to).encode("iso-8859-1"), 
                      :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=suscriptores.csv" }
      end
    end
    
  end
  
  def purchases
    add_breadcrumb "Evolución de compras", :reports_purchases_path
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_week
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end
    
  end
  
  def products_detail_excel
    add_breadcrumb "Descargar detalle de productos", :reports_products_detail_excel_path
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.utc.beginning_of_year
      @to = DateTime.now.utc.end_of_week
    else
      @from = Time.parse(params[:from]).utc.beginning_of_day
      @to = Time.parse(params[:to]).utc.end_of_day
    end    
    if params[:commit] == 'Descargar Reporte'
      respond_to do |format|
        format.html
        format.csv { send_data Dress.to_csv(@from, @to).encode("iso-8859-1"), 
                      :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=detalle_productos.csv" }
      end
    end
  end
     
  private

  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
  end
  
  def export_wbr(wbr_data,init_year,end_year,init_week,end_week)
    header = Array.new
    header << 'Semana'
    sales = Array.new
    sales << 'Sales'
    cash_in = Array.new
    cash_in << 'Cash In'
    credits = Array.new
    credits << 'Credits'
    delivery_income = Array.new
    delivery_income << 'Delivery Income'
    products_cost = Array.new
    products_cost << 'Products Costs' 
    tax = Array.new
    tax << 'Tax' 
    delivery_cost = Array.new
    delivery_cost << 'Delivery Cost'
    refunds = Array.new
    refunds << 'Refunds'
    revenue = Array.new
    revenue << 'Revenue'
    margin = Array.new
    margin << 'Margin'
    purchases_made = Array.new
    purchases_made << 'Purchases Made'
    products_sold = Array.new
    products_sold << 'Products Sold'
    
    (init_year..end_year).each do |year|
    	(init_week..end_week).each do |week|
        header << week.to_s+' - '+year.to_s
    		sales << wbr_data[week.to_s+' - '+year.to_s][:sales_week]
        cash_in << wbr_data[week.to_s+' - '+year.to_s][:price_week]
        credits << wbr_data[week.to_s+' - '+year.to_s][:credits_week]
        delivery_income << wbr_data[week.to_s+' - '+year.to_s][:dispatch_income_week]
        products_cost << wbr_data[week.to_s+' - '+year.to_s][:cost_week]
        tax << wbr_data[week.to_s+' - '+year.to_s][:cost_week]*(1/0.81-1)
        delivery_cost << wbr_data[week.to_s+' - '+year.to_s][:dispatch_cost_week]
        refunds << wbr_data[week.to_s+' - '+year.to_s][:refunds_week]
        revenue << wbr_data[week.to_s+' - '+year.to_s][:revenue_week]
        margin << wbr_data[week.to_s+' - '+year.to_s][:margin_week]
        purchases_made << wbr_data[week.to_s+' - '+year.to_s][:purchases_week]
        products_sold << wbr_data[week.to_s+' - '+year.to_s][:prod_week]
    	end
    end
    
    CSV.generate do |csv|
      csv << header
      csv << sales
      csv << cash_in
      csv << credits
      csv << delivery_income
      csv << products_cost
      csv << tax
      csv << delivery_cost
      csv << refunds
      csv << revenue
      csv << margin
      csv << purchases_made
      csv << products_sold
    end
  end
end
