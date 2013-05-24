module ReportsHelper

	def total_expected_flow_in(leads, month)
	  total = 0
	  leads.each do |lead|
	    total = total + lead.expected_flow_in(month)
    end
    return total.to_i
	end
	
	def count_link_challenge_activity(matriclicker, type, s, e)
    type_id = @llamada.id if type == 'call'
    type_id = @reunion.id if type == 'meeting'
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")

    if matriclicker == 'all_matriclickers'
      count = ChallengeActivity.where('challenge_activity_type_id = ? and created_at >= ? and created_at <= ?', 
      type_id, starting_full, ending_full).count
      
      link_to number_with_delimiter(count),
  	  reports_activity_details_path(:from => s, :to => e, :activity_type => type_id)
    else
      count = matriclicker.challenge_activities.where('challenge_activity_type_id = ? and created_at >= ? and created_at <= ?', 
      type_id, starting_full, ending_full).count
      
      link_to number_with_delimiter(count),
  	  reports_activity_details_path(:from => s, :to => e, :matriclicker_id => matriclicker.id, :activity_type => type_id)
    end
	end
	
	def calculation_link_invoices(s, e, calculation = 'count', status = nil)
	  starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")
    
    if status.nil?
      calc = eval "Invoice.where('issued_date >= ? and issued_date <= ?', '#{starting_full}', '#{ending_full}').#{calculation}"
      link_to number_with_delimiter(calc.round), reports_invoices_details_path(:from => s, :to => e)
    elsif status == "Pagada"
      calc = eval "Invoice.where('issued_date >= ? and issued_date <= ? and paid = true', '#{starting_full}', '#{ending_full}').#{calculation}"
      link_to number_with_delimiter(calc.round), reports_invoices_details_path(:from => s, :to => e, :paid => true)
    end
  end
  
  def calculation_ratio_invoices(s, e, calculation = 'count')
	  starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")
    
    all = eval "Invoice.where('issued_date >= ? and issued_date <= ?', '#{starting_full}', '#{ending_full}').#{calculation}"
    paid = eval "Invoice.where('issued_date >= ? and issued_date <= ? and paid = true', '#{starting_full}', '#{ending_full}').#{calculation}"

    if all > 0 
      number_to_percentage(100 * paid.to_f / all, :precision => 0) 
    else 
      number_to_percentage(0, :precision => 0)
    end
  end
  
	def count_link_contracts(matriclicker, s, e)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")

    now = (DateTime.now + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    
    if matriclicker == 'all_matriclickers'
      count = Contract.where('created_at >= ? and created_at <= ? and end_contract_date >= ?', 
      starting_full, ending_full, now).count
  		link_to number_with_delimiter(count), reports_contracts_details_path(:from => s, :to => e)
    else
      count = matriclicker.contracts.where('created_at >= ? and created_at <= ? and end_contract_date >= ?', 
      starting_full, ending_full, now).count
  		link_to number_with_delimiter(count), reports_contracts_details_path(:from => s, :to => e, :matriclicker_id => matriclicker.id)
    end
	end
	
	def count_link_contracts_by_type(s, e, type = nil)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")
    
    now = (DateTime.now + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    
    if type.nil?
      count = Contract.where('created_at >= ? and created_at <= ? and end_contract_date >= ?', 
      starting_full, ending_full, now).count
  		link_to number_with_delimiter(count), reports_contracts_details_path(:from => s, :to => e)
    else
      count = type.contracts.where('contracts.created_at >= ? and contracts.created_at <= ? and end_contract_date >= ?', 
      starting_full, ending_full, now).count
  		link_to number_with_delimiter(count), reports_contracts_details_path(:from => s, :to => e, :contract_type_id => type.id)
    end
	end
	
	def count_link_users(s, e)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")

  	count = User.where('created_at <= ?', ending_full).where('email not like "%invitado%"').count
  	
  	number_with_delimiter(count)
	end
	
	def count_link_couples(s, e)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")

  	grooms = Groom.where('created_at <= ?', ending_full).where('email is not null and email not like "%@matriclick%" and email <> ""').count
  	brides = Bride.where('created_at <= ?', ending_full).where('email is not null and email not like "%@matriclick%" and email <> ""').count
  	
  	number_with_delimiter(grooms + brides)
	end
	
	def count_link_conversations(i, s, e)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")
    
    supplier_accounts = SupplierAccount.where(:country_id => session[:country].id).from_industry(i).joins(:conversations).approved.where('conversations.created_at >= ? and conversations.created_at <= ?', starting_full, ending_full)
    count = supplier_accounts.count #Cuento los proveedores con nuevas conversaciones
    
    alert = false
    supplier_accounts.each do |sa|
      conv = sa.conversations.where('conversations.created_at >= ? and conversations.created_at <= ?', starting_full, ending_full)
      conv.each do |c|
        if c.messages.count == 1
          alert = true
        end
      end
      break if alert
    end
    
    if check_if_privilege('Mensajes')
  	  link_to number_with_delimiter(count), reports_conversations_details_path(:from => s, :to => e, :industry_category_id => i.id), 
  	          :style => (alert ? 'color:red; font-weight:bold;' : '')
    else
      number_with_delimiter(count)
    end
	end

	def count_link_all_conversations(s, e)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")

    count = SupplierAccount.where(:country_id => session[:country].id).joins(:conversations).approved.where('conversations.created_at >= ? and conversations.created_at <= ?', 
            starting_full, ending_full).count
  
    if check_if_privilege('Mensajes')
  	  link_to number_with_delimiter(count), reports_conversations_details_path(:from => s, :to => e)
    else
      number_with_delimiter(count)
    end
	end
	
	def count_link_conversations_supplier_account(sa, s, e)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")
    
    conversations = sa.conversations.where('conversations.created_at >= ? and conversations.created_at <= ?', 
                    starting_full, ending_full)
    count = conversations.count
    
    alert = false
    conversations.each do |c|
      if c.messages.count == 1
          alert = true
        break
      end
    end
            
    if check_if_privilege('Mensajes')
  	  link_to number_with_delimiter(count), reports_conversations_details_path(:from => s, :to => e, :supplier_account_id => sa.id), 
  	          :style => (alert ? 'color:red; font-weight:bold;' : '')
	  else
	    number_with_delimiter(count)
    end
	end
	  
	def count_link_dresses(dress_type, s, e)
	  starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")
    
    count = DressRequest.from_type(dress_type).where('dress_requests.created_at >= ? and dress_requests.created_at <= ?', 
            starting_full, ending_full).count

    if check_if_privilege('Salestool')
  	  link_to number_with_delimiter(count), reports_dresses_details_path(:dress_type_id => dress_type, :from => s, :to => e)
	  else
	    number_with_delimiter(count)
    end
  end
	
	def count_link_all_dresses(s, e)
	  starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")

    count = DressRequest.where('dress_requests.created_at >= ? and dress_requests.created_at <= ?', 
            starting_full, ending_full).count
    
    if check_if_privilege('Salestool')
  	  link_to number_with_delimiter(count), reports_dresses_details_path(:from => s, :to => e)
	  else
	    number_with_delimiter(count)
    end
            
  end
	
	def count_link_purchases(s, e, status = nil)
    starting_full = (s + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e + 4.hour).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s + 4.hour).strftime("%Y-%m-%d")
    ending_short = (e + 4.hour).strftime("%Y-%m-%d")

    if status == 'finalizado'
      count = Purchase.where('created_at >= ? and created_at <= ? and status = ?', starting_full, ending_full, status).count
    else
      status = 'all'
      count = Purchase.where('created_at >= ? and created_at <= ?', starting_full, ending_full).count
    end
    
    if check_if_privilege('Vestidos')
      link_to number_with_delimiter(count), purchases_path(:from => s, :to => e, :status => status)
  	else
  	  number_with_delimiter(count)
    end
  end
  
end
