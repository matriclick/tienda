module DressesHelper
  def dispatch_cost_apply(dress)
    case dress.supplier_account.supplier_account_type.name
      when 'Vestidos de Novia Usados', 'Vestidos Boutique'
        return false
      else
        return true
    end
  end
  
  def link_to_next_dress(name, object, type, css_class = nil)
    @objects = select_related_dresses(object, type)
    
 		if !@objects.blank?
  		@index = @objects.index(object)

  		if @index.nil?
  		  @index = @objects.index(@objects.first)
  		  object = @objects.first
  	  end
      
  		if @objects.last == object	
  			@next_object = @objects.first
  		else
  			@next_object = @objects.at(@index + 1)
  		end

  		@supplier_account = object.supplier_account

  		return link_to(name, dress_ver_path(:type => type.name, :slug => @next_object.slug), :class => css_class )
    end
	end
	
	def link_to_previous_dress(name, object, type, css_class = nil)
		@objects = select_related_dresses(object, type)

		if !@objects.blank?
	    @index = @objects.index(object)

  		if @index.nil?
  		  @index = @objects.index(@objects.first)
  		  object = @objects.first
  	  end

  		if @objects.first == object
  			@previous_object = @objects.last
  		else
  			@previous_object = @objects.at(@index - 1)
  		end

  		@supplier_account = object.supplier_account

  		return link_to(name, dress_ver_path(:type => type.name, :slug => @previous_object.slug), :class => css_class )
    end
	end
	
	def select_related_dresses(object, type)
	  return type.dresses.available
  end
	
end
