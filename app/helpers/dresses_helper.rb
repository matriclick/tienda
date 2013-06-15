module DressesHelper
  
  def link_cloth_measure(size)
    @measure_for_size = @cloth_measures.detect{|measure| measure.size_id == size.id }
    if !@measure_for_size.nil? and !@measure_for_size.bust.nil? and !@measure_for_size.waist.nil? and !@measure_for_size.hips.nil?
      link_to '(editar medidas '+@measure_for_size.bust.ceil.to_s+' x '+@measure_for_size.waist.ceil.to_s+' x '+@measure_for_size.hips.ceil.to_s+')', 
              edit_cloth_measure_path(@measure_for_size), :id => 'form_inline', :style => 'margin-left:10px', :class => 'no_underline'
    elsif !@measure_for_size.nil? and (@measure_for_size.bust.nil? or @measure_for_size.waist.nil? or @measure_for_size.hips.nil?)
      link_to '(completar medidas)', edit_cloth_measure_path(@measure_for_size), :id => 'form_inline', :style => 'margin-left:10px', :class => 'no_underline'
    else
      link_to '(agregar medidas)', new_cloth_measure_path(:u => @dress.id, :size_id => size.id), 
              :id => 'form_inline', :style => 'margin-left:10px', :class => 'no_underline'
    end
  end
  
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
