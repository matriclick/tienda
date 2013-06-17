# encoding: UTF-8
class UserProfileController < ApplicationController
  before_filter :authenticate_user!
	
  def purchases
    add_breadcrumb 'Tu cuenta', user_profile_personalization_path
    add_breadcrumb 'Compras realizadas', user_profile_path
    
	  @purchases = current_user.purchases.where(:status => 'finalizado').order 'created_at DESC'
  end
  
  def personalization
    add_breadcrumb 'Tu cuenta', user_profile_personalization_path
    add_breadcrumb 'Personalización', user_profile_personalization_path
    @cloth_measure = current_user.cloth_measure
    @tags = current_user.tags
  end
  
  def edit_tags
    add_breadcrumb 'Tu cuenta', user_profile_personalization_path
    add_breadcrumb 'Personalización', user_profile_personalization_path
    add_breadcrumb 'Estilo', user_profile_edit_tags_path
    @tags = Tag.all
    @user = current_user
  end

  def update_tags
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_profile_personalization_path }
        format.json { head :ok }
      end
    end
  end
  
end
