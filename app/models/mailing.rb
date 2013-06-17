class Mailing < ActiveRecord::Base
  
  def self.get_personalized_mailing_information(users, dresses)
    data = Hash.new
    
    users.each do |user|
      data[user.id] = Array.new
      dresses.each do |dress|
        user_tags = user.tags
        dress_tags = dress.tags
        user_cloth_measure = user.cloth_measure
        dress_cloth_measures = dress.cloth_measures
        
        tag_match = Mailing.check_if_tags_match(user_tags, dress_tags)
        measure_match = Mailing.check_if_measures_match(user_cloth_measure, dress_cloth_measures)

        if tag_match and measure_match
          data[user.id] << dress.id
        end
        
      end
    end
    return data
    
  end
  
  #Si el usuario no tiene tags o el vestido no tiene tags, entonces retorna falso
  def self.check_if_tags_match(user_tags = nil, dress_tags = nil)
    if user_tags.nil? or dress_tags.nil?
      return false
    else
      dress_tags.each do |dress_tag|
        if user_tags.include?(dress_tag)
          return true
        end
      end
      return false
    end
  end
  
  def self.check_if_measures_match(user_cloth_measure, dress_cloth_measures)
    tolerance = {:bust => 20, :waist => 20, :hips => 20, :shoe_size => 1}
    match_found = false
    dress_cloth_measures.each do |cloth_measure|
      match_found = (match_found or cloth_measure.similar_to(user_cloth_measure, tolerance))
    end
    return match_found
  end
  
end
