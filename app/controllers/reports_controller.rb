# encoding: UTF-8
class ReportsController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  before_filter { redirect_unless_privilege('Reportes') }
  helper_method :sort_column, :sort_direction
  
  def salestool
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @llamada = ChallengeActivityType.find_by_name("Llamada")
    @reunion = ChallengeActivityType.find_by_name("Reunion")
    @matriclickers = Matriclicker.active
  end
  
  def users
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
  end
  
  def dresses
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @wedding_type = DressType.find_by_name("vestidos-novia") 
    @party_type = DressType.find_by_name("vestidos-fiesta")
    @bridesmaid_type = DressType.find_by_name("vestidos-madrina")
  end
    
  def suppliers
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @industry_categories = IndustryCategory.all.joins(:countries).where("countries.id = ?", session[:country].id).sort_by {|ic| -SupplierAccount.where(:country_id => session[:country].id).from_industry(ic).joins(:conversations).approved.count }
  end
  
  def industry_category_details
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @industry_category = IndustryCategory.find params[:industry_category_id]
    @supplier_accounts = @industry_category.supplier_accounts.where(:country_id => session[:country].id).sort_by {|sa| -sa.conversations.count }
  end
  
  def suppliers_with_contract
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @fijo = ContractType.find_by_name("Fijo")
    @mixto = ContractType.find_by_name("Mixto")
    @especial = ContractType.find_by_name("Especial")
    
    @contracts_fijo = Contract.where(:contract_type_id => @fijo.id)
    @contracts_mixto = Contract.where(:contract_type_id => @mixto.id)
    @contracts_especial = Contract.where(:contract_type_id => @especial.id)
    
    @leads = Array.new
    
    @contracts_fijo.each do |c|
      @leads << c.lead if !c.lead.nil? and !@leads.include?(c.lead)
    end
    @contracts_mixto.each do |c|
      @leads << c.lead if !c.lead.nil? and !@leads.include?(c.lead)
    end
    @contracts_especial.each do |c|
      @leads << c.lead if !c.lead.nil? and !@leads.include?(c.lead)
    end
    
    @leads.sort_by! {|lead| -(lead.supplier_account.nil? ? 0 : lead.supplier_account.conversations.count) }
    
  end
  
  def conversations_details
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    if !params[:industry_category_id].nil?
      @ic = IndustryCategory.find params[:industry_category_id]
      @conversations = Conversation.from_industry(@ic).where('conversations.created_at >= ? and conversations.created_at <= ?', @from, @to).order 'created_at DESC'
    elsif !params[:supplier_account_id].nil?
      @supplier_account = SupplierAccount.find params[:supplier_account_id]
      @conversations = @supplier_account.conversations.where('created_at >= ? and created_at <= ?', @from, @to).order 'created_at DESC'
    else
      @conversations = Conversation.where('created_at >= ? and created_at <= ?', @from, @to).order 'created_at DESC'
    end
    
  end
  
  def conversations_without_reply
    @conversations = []
    Conversation.all.each do |conversation|
      if !conversation.messages.blank?
        if conversation.messages.size == 1
          @conversations << conversation
        end
      end
    end
  end
  
  def user_conversations
     if params[:from].nil? or params[:to].nil?
        @from = DateTime.now.beginning_of_week
        @to = DateTime.now.end_of_week
      else
        @from = Time.parse(params[:from])
        @to = Time.parse(params[:to])
      end
      
      if !params[:user_email].nil?
        @user = User.find_by_email params[:user_email]
        @conversations = @user.conversations.order 'created_at DESC'
      elsif !params[:supplier_email].nil?
        @user = Supplier.find_by_email params[:supplier_email]
        @conversations = @user.supplier_account.conversations.order 'created_at DESC'
      else
        redirect_to administration_index_path
      end
  end
  
  def list_user_conversations
   
   if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_year
      @to = DateTime.now.end_of_year
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end

    @users = User.joins(:conversations).where('conversations.created_at >= ? and conversations.created_at <= ?', @from, @to).uniq
        
    sort = sort_column
    order = sort_direction
    
    if sort == 'conversations_count'
      order == 'desc' ? @users.sort_by! {|u| -u.conversations.count } : @users.sort_by! {|u| u.conversations.count }
    elsif sort == 'wedding_date'
      order == 'desc' ? @users.sort_by! {|u| u.user_account.wedding_tentative_date }.reverse! : @users.sort_by! {|u| u.user_account.wedding_tentative_date }
    elsif sort == 'last_conversation'  
      order == 'desc' ? @users.sort_by! {|u| u.conversations.last.created_at }.reverse! : @users.sort_by! {|u| u.conversations.last.created_at }
    else
      order == 'desc' ? @users.sort_by! {|u| u.email } : @users.sort_by! {|u| u.email }.reverse!
    end
  end
  
  def activity_details
    @activity_type = ChallengeActivityType.find params[:activity_type]

    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end

    if !params[:matriclicker_id].nil?
      @matriclicker = Matriclicker.find params[:matriclicker_id]    
      @challenge_activities = @matriclicker.challenge_activities.
      where('challenge_activity_type_id = ? and created_at >= ? and created_at <= ?', @activity_type.id, @from, @to)
    else
      @challenge_activities = ChallengeActivity.
      where('challenge_activity_type_id = ? and created_at >= ? and created_at <= ?', @activity_type.id, @from, @to)
    end
  end
  
  def invoices
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_year
      @to = DateTime.now.next_month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end

  end
  
  def invoices_list
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_month
      @to = DateTime.now.end_of_month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @invoices = Invoice.where('issued_date >= ? and issued_date <= ?', @from, @to)
    
  end
  
  def debtor_list
    redirect_unless_privilege('Finanzas')

    if params[:from].nil? or params[:to].nil?
      @from = DateTime.parse("2012-01-01")
      @to = DateTime.now.end_of_month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end

    @leads = Lead.joins(:invoices).where(:country_id => session[:country].id).where('invoices.issued_date >= ? and issued_date <= ?', @from, @to)
    @leads = @leads.uniq
    @leads.sort_by! {|lead| -lead.unpaid_invoices.size}
    
  end
  
  def invoices_details
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_year
      @to = DateTime.now.next_month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    if params[:paid].nil?
      @invoices = Invoice.where('issued_date >= ? and issued_date <= ?', @from, @to)
    else
      @invoices = Invoice.where('issued_date >= ? and issued_date <= ? and paid = true', @from, @to)      
    end
  end
  
  def collections
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_month
      @to = DateTime.now.end_of_month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end

    @fijo = ContractType.find_by_name("Fijo")
    @mixto = ContractType.find_by_name("Mixto")
    @especial = ContractType.find_by_name("Especial")
    
    # Contratos que aún se tienen que facturar y que no han sido facturados
    # --> Contratos que su fecha de término de facturación es menor al fin de este mes
    # --> y que no se ha facturado (cobrado) este mes
    @invoice_months = InvoiceMonth.where('month >= ? and year >= ?', @from.month, @from.year)
    
    @contracts = Contract.where('contracts.invoice_to >= ? and contracts.invoice_from <= ? and 
      (contracts.contract_type_id = ? or contracts.contract_type_id = ? or contracts.contract_type_id = ?)', 
      @from, @from, @fijo.id, @mixto.id, @especial.id)

    @invoice_months.each do |im|
      im.invoices.each do |invoice|
        @contracts.delete_if{ |x| x == invoice.contract }
      end
    end
  end
  
  def expected_flow
    redirect_unless_privilege('Finanzas')

    max_invoice_date = Contract.maximum(:invoice_to)
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_month
      @to = max_invoice_date.to_datetime.end_of_month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @months_to_report_string = (@from.to_date..@to.to_date).map{ |date| date.strftime("%Y %b") }.uniq
    @months_to_report_date_time = []
    @months_to_report_string.each do |month_to_report_string|
      @months_to_report_date_time << DateTime.parse(month_to_report_string)
    end
    
    @leads = Lead.where(:country_id => session[:country].id)
  end
  
  def collections_email
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_month
      @to = DateTime.now.end_of_month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    if params[:order] == 'mail'
      @order = 'mail'
      @h1_title = 'Envío de correos de cobranzas'
      @invoices = Invoice.where('issued_date >= ? and issued_date <= ?', @from, @to).order 'collection_mail_sent, date_collection_mail_sent ASC'
    else
      @order = 'paid'
      @h1_title = 'Revisión de pagos'
      @invoices = Invoice.where('issued_date >= ? and issued_date <= ?', @from, @to).order 'paid DESC, pay_date ASC'
    end
    
  end
  
  def contracts
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    @fijo = ContractType.find_by_name("Fijo")
    @mixto = ContractType.find_by_name("Mixto")
    @variable = ContractType.find_by_name("Variable")
    @especial = ContractType.find_by_name("Especial")
    
  end
  
  def contracts_expiration
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_month + 1.month
      @to = DateTime.now.end_of_month + 1.month
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    @contracts = Contract.where('end_contract_date between ? and ?', @from, @to).order('end_contract_date')
  end
  
  def contracts_details
    redirect_unless_privilege('Finanzas')
    
    if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
    now = (DateTime.now + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
        
    if !params[:matriclicker_id].nil?
      @matriclicker = Matriclicker.find params[:matriclicker_id]
      @contracts = @matriclicker.contracts.where('created_at >= ? and created_at <= ? and end_contract_date >= ?', @from, @to, now)
    elsif !params[:contract_type_id].nil?
      @type = ContractType.find params[:contract_type_id]
      @contracts = @type.contracts.where('created_at >= ? and created_at <= ? and end_contract_date >= ?', @from, @to, now)
    else
      @contracts = Contract.where('created_at >= ? and created_at <= ? and end_contract_date >= ?', @from, @to, now)
    end
  end
  
  def dresses_details
   if params[:from].nil? or params[:to].nil?
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
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
      @from = DateTime.now.beginning_of_week
      @to = DateTime.now.end_of_week
    else
      @from = Time.parse(params[:from])
      @to = Time.parse(params[:to])
    end
    
  end
  
  def export
    # Método sirve para exportar tablas completas y sin joins
    exporting = params[:exporting]

    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    
    if exporting == 'users'
      data = User.all
      header = ['email', 'updated_at']
      sheet1.row(0).concat header
      
    elsif exporting == 'novios'
      data = Groom.where('email is not null and email not like "%@matriclick%" and email <> ""')
    	
      header = ['name', 'updated_at']
      sheet1.row(0).concat header
    elsif exporting == 'novias'
      data = Groom.where('email is not null and email not like "%@matriclick%" and email <> ""')
    	
      header = ['name', 'updated_at']
      sheet1.row(0).concat header      
    else
      redirect_to administration_index_path
    end

    row_count = 1;     
    data.each do |value|
      row = sheet1.row(row_count)
      header.each do |att|      
        row.push eval("value.#{att}")
      end
      row_count = row_count + 1
    end
    
    spreadsheet = StringIO.new 
    book.write spreadsheet
    send_data spreadsheet.string, :filename => exporting+".xls", :type =>  "application/vnd.ms-excel"
  end
   
  def export_dress_info
     exporting = params[:exporting]

     book = Spreadsheet::Workbook.new
     sheet1 = book.create_worksheet

     data = Dress.includes(:dress_requests).uniq.sort_by {|dr| -dr.dress_requests.count }

     header = ['id', 'requests', 'name', 'tipo', 'estado', 'price', 'vendedor', 'email', 'telefono', 'posicion' ]
     sheet1.row(0).concat header

     row_count = 1;     
     data.each do |dress|
       row = sheet1.row(row_count)
       
       row.push(dress.id)
       row.push(dress.dress_requests.count)
       if !dress.dress_type.nil?
          row.push(dress.dress_type.name)
        else
          row.push('n/d')
       end
       if !dress.dress_status.nil?
          row.push(dress.dress_status.name)
          row.push('n/d')
       end
       row.push(dress.price)
       if !dress.supplier_account.nil?
       	if dress.supplier_account.supplier_account_type.name == 'Vestidos de Novia Usados'
       		row.push(dress.seller_name)
       		row.push(dress.seller_phone_number)
       		row.push(dress.seller_email)
       	else
       	  if !dress.supplier_account.supplier_contacts.last.nil?
         		row.push(dress.supplier_account.fantasy_name+' ('+dress.supplier_account.supplier_contacts.last.name+')')
         		row.push(dress.supplier_account.supplier_contacts.first.phone_number)
         		row.push(dress.supplier_account.supplier_contacts.first.email)
     	    else
            row.push('n/d')
            row.push('n/d')
            row.push('n/d')
   	      end
       	end
     	 else
          row.push('n/d')
          row.push('n/d')
          row.push('n/d')
       end
       row.push(dress.position)
       row_count = row_count + 1
     end

     spreadsheet = StringIO.new 
     book.write spreadsheet
     send_data spreadsheet.string, :filename => exporting+".xls", :type =>  "application/vnd.ms-excel"
  end
   
  private

  def sort_column
    %w[conversations_count wedding_date last_conversation email].include?(params[:sort]) ? params[:sort] : "conversations_count"
  end

  def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
    
end
