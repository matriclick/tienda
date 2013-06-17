module UserProfileHelper
  
  def get_bust_link
    if @cloth_measure.nil? 
      link_to('= ?', new_cloth_measure_path(:u => 'ok'), class: 'no_underline') 
    elsif @cloth_measure.bust.nil?
      link_to('= ?', edit_cloth_measure_path(@cloth_measure), class: 'no_underline') 
    else
      link_to('= '+@cloth_measure.bust.ceil.to_s+' cms', edit_cloth_measure_path(@cloth_measure), class: 'no_underline')
    end
  end
  
  def get_waist_link
    if @cloth_measure.nil? 
      link_to('= ?', new_cloth_measure_path(:u => 'ok'), class: 'no_underline') 
    elsif @cloth_measure.waist.nil?
      link_to('= ?', edit_cloth_measure_path(@cloth_measure), class: 'no_underline') 
    else
      link_to('= '+@cloth_measure.waist.ceil.to_s+' cms', edit_cloth_measure_path(@cloth_measure), class: 'no_underline')
    end
  end
  
  def get_hips_link
    if @cloth_measure.nil? 
      link_to('= ?', new_cloth_measure_path(:u => 'ok'), class: 'no_underline') 
    elsif @cloth_measure.hips.nil?
      link_to('= ?', edit_cloth_measure_path(@cloth_measure), class: 'no_underline') 
    else
      link_to('= '+@cloth_measure.hips.ceil.to_s+' cms', edit_cloth_measure_path(@cloth_measure), class: 'no_underline')
    end
  end
  
  def get_shoe_link
    if @cloth_measure.nil? 
      link_to('= ?', new_cloth_measure_path(:u => 'ok'), class: 'no_underline') 
    elsif @cloth_measure.shoe_size.nil?
      link_to('= ?', edit_cloth_measure_path(@cloth_measure), class: 'no_underline')
    else
      link_to('= talla  '+@cloth_measure.shoe_size.size_cl.ceil.to_s, edit_cloth_measure_path(@cloth_measure), class: 'no_underline')
    end
  end  
end
