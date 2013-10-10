module ReportsHelper

	def count_link_users(s, e)
    starting_full = s.strftime("%Y-%m-%d %H:%M:%S")
    ending_full = e.strftime("%Y-%m-%d %H:%M:%S")
    starting_short = s.strftime("%Y-%m-%d")
    ending_short = e.strftime("%Y-%m-%d")

  	count = User.where('created_at <= ?', ending_full).size
  	
  	number_with_delimiter(count)
	end

	def count_link_subscribers(s, e)
    starting_full = (s).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s).strftime("%Y-%m-%d")
    ending_short = (e).strftime("%Y-%m-%d")

  	count = Subscriber.where('created_at <= ?', ending_full).size
  	
  	number_with_delimiter(count)
	end


	def count_link_purchases(s, e, status = nil)
    starting_full = (s).strftime("%Y-%m-%d %H:%M:%S")
    ending_full = (e).strftime("%Y-%m-%d %H:%M:%S")
    starting_short = (s).strftime("%Y-%m-%d")
    ending_short = (e).strftime("%Y-%m-%d")

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
