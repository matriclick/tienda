# encoding: UTF-8
class UserProfileController < ApplicationController
  before_filter :authenticate_user!
	
  def purchases
    add_breadcrumb 'Tu cuenta', user_profile_path
	  @purchases = current_user.purchases.where(:status => 'finalizado').order 'created_at DESC'
  end
  
  def personalization
    add_breadcrumb 'Tu cuenta', user_profile_path
    add_breadcrumb 'Personalización', user_profile_personalization_path
    @cloth_measure = current_user.cloth_measure
  end
  
  def save_cloth_measure
  
  end
  
end
