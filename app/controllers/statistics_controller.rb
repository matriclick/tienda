class StatisticsController < ApplicationController
  require 'oauth'
  require 'analytics.rb'
  before_filter :check_supplier, :set_supplier_layout, :find_supplier, :authenticate_analytics
  
  def index
    supplier_account = @supplier.supplier_account
    #Require the page views
    # filter = get_filter(supplier_account)
    #Get Google Analytics params
    #@product_views = get_monthly_views(@profile,products_url , 6)
    #@service_views = get_monthly_views(@profile,services_url, 6)
    # unless @profile.blank?
    #   @total_views = get_monthly_views(supplier_account)
    # else
    #   @total_views = nil
    # end
		
		# FGM: TODO un-tweak page views and get Google Analytics
		@total_views = get_monthly_views(supplier_account)
		
		#HH
    #Get Contact Views
    @total_contact_views =  get_monthly_views(supplier_account, 'Contacto')
    
    #Get Messages params
    #@product_conversations = get_last_conversations(@supplier.supplier_account.conversations.of_products, 6)
    #@service_conversations = get_last_conversations(@supplier.supplier_account.conversations.of_services, 6)
    @total_conversations =  get_last_conversations(supplier_account.conversations, 6)
        
    #Get Budgets
    #@product_budgets
    #@service_budgets
    @total_budgets = get_budgets(supplier_account)
    
    
    #HH Static statistics
    view_type_presentation = ViewCountType.find_by_name 'Presentacion'
    view_type_contact = ViewCountType.find_by_name 'Contacto'
    
    @cummulative_page_views = SupplierPageView.where('view_count_type_id = ? and supplier_account_id = ?', view_type_presentation.id, supplier_account.id).sum('count')
    @cummulative_contact_views = SupplierPageView.where('view_count_type_id = ? and supplier_account_id = ?', view_type_contact.id, supplier_account.id).sum('count')
    @cummulative_unique_views = SupplierPageView.where('view_count_type_id = ? and supplier_account_id = ?', view_type_presentation.id, supplier_account.id).count('id')
    
  end

  def show
  end

private
  def authenticate_analytics
		@profile ||= get_profile
  end

  def get_profile
  #Create our own customer in order to get our analytics
  #WARNING: Consumer ID and PASSWORD have to be always validated
  begin
    consumer = OAuth::Consumer.new('552360206826.apps.googleusercontent.com', 'sdXv2dBgv0JgFVkFa64b9Gdc',  {  
    :site => 'https://www.google.com',
    :request_token_path => '/accounts/OAuthGetRequestToken',
    :access_token_path => '/accounts/OAuthGetAccessToken',
    :authorize_path => '/accounts/OAuthAuthorizeToken'})

    Garb::Session.access_token = Garb::Session.access_token = OAuth::AccessToken.new(consumer,'1/Lnmu3S8szmT2BHCzG_gatv1zxVvHNIyxvav3gIJBk8I','jguIm4xf_1zvXTZ4vIFq38Wd')
    profile = Garb::Management::Profile.all.detect {|profile| profile.web_property_id == 'UA-27704875-1'}
  rescue
    profile = nil
    #ERROR MESSAGE
  end

    return profile
  end
  
  #Ger suppliers last visits for page_path
  def get_monthly_views(supplier_account, view_type_name = 'Presentacion', time_span = 6)
    #Results with dimensions defined in analytics.rb
    # views = Analytics.results(profile, :start_date => quantity.months.ago(Date.today), :end_date => Date.today, :filters => {:pagepath.contains => filter})

    #Building our array. {"Month" => "page_views"}
    # monthly_views = views.inject({}) do |result, element|
    #   name = Date::MONTHNAMES[element.month.to_i]
    #   result[name] = element.pageviews.to_i + result[name].to_i
    #   result = Hash[result.sort]
    # end

		# FGM: Analytics tweak
		# FGM: TODO: Get real Google Analytics
		monthly_views = Hash.new(0)
		
		view_type = ViewCountType.find_by_name view_type_name
		
		supplier_account.supplier_page_views.where('created_at > ? and view_count_type_id = ?', Date.today - time_span.months, view_type.id).order('created_at ASC').collect do |x|
			monthly_views[Date::MONTHNAMES[x.created_at.month]] += 1 
		end
		
    return add_empty_months(monthly_views, 6)
  end

  #Hash with every month and its quantity
  def get_last_conversations(query, quantity)
    monhly_conversations = Hash.new(0)
     query.where(:created_at => (quantity.months.ago(Time.now)..Time.now)).order("created_at ASC").collect do |x| 
      monhly_conversations[Date::MONTHNAMES[x.created_at.month]] += 1 
    end
    return add_empty_months(monhly_conversations,6)
  end
  
  def get_budgets(supplier_account, time_span = 6)
    monthly_budgets = Hash.new(0)
		
    supplier_account.services.collect do |service|
      Budget.where(budgetable_type: "Service", budgetable_id: service.id, :created_at => (time_span.month.ago(Time.now)..Time.now)).order('created_at ASC').collect do |x| 
        monthly_budgets[Date::MONTHNAMES[x.created_at.month]] += 1 
      end
    end
    supplier_account.products.collect do |product|
     Budget.where(budgetable_type: "Product", budgetable_id: product.id, :created_at => (time_span.month.ago(Time.now)..Time.now)).order('created_at ASC').collect do |x| 
        monthly_budgets[Date::MONTHNAMES[x.created_at.month]] += 1
      end
    end
		add_empty_months(monthly_budgets, time_span)
  end

  #Adds empty months to the hash up to given quantity (months_hash.count >= size), else returns nil
  def add_empty_months(months_hash, quantity)
    #Adding the other empty months
    size = months_hash.count
    empty_array = Hash.new
    if(size < quantity)
      for i in 0..(quantity-size)
          empty_array =empty_array.merge(Hash[Date::MONTHNAMES[(quantity-i).months.ago(Date.today).month], 0]) 
      end
    end
    return months_hash = empty_array.merge(months_hash)
  end

  #REGEXP filter as a string to get all of the accounts product and services
  def get_filter(supplier_account)
    products_ids = Array.new
    services_ids = Array.new
    
    #Getting products and services ids
    supplier_account.products.each{|product| products_ids << product.id}
    supplier_account.services.each{|service| services_ids << service.id}

    #Building the Regexp string ( WITHOUT "/" or|and "\" )
    #EXAMPLE: products_and_services_catalog+.+((25|15)+.+(class=Product)|(36)+.+(class=Service))
    filter =  'products_and_services_catalog+.+(('
    products_ids.each{|id| filter << "#{id}|"}
    filter = filter.chop << ')+.+(class=Product)|('
    services_ids.each{|id| filter << "#{id}|"}
    filter = filter.chop << ')+.+(class=Service))'

    return filter
  end
end
