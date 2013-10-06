# encoding: UTF-8
class UserProfileController < ApplicationController
  before_filter :authenticate_user!
	
  def contests
    add_breadcrumb 'Tu cuenta', user_profile_personalization_path
    add_breadcrumb 'Concursos', user_profile_contests_path
  end
  
  def information
    add_breadcrumb 'Tu cuenta', user_profile_personalization_path
    add_breadcrumb 'Información Personal', user_profile_information_path
    
    @user = current_user
  end
  
  def add_to_wish_list
    user = current_user
    dress = Dress.find params[:dress_id]
    
    if user.dresses.include? dress
      user.dresses.delete dress
    else
      user.dresses << dress
    end
    user.save
    
    redirect_to session[:matriclick_last_url]
  end
  
  def wish_list
    add_breadcrumb 'Tu cuenta', user_profile_personalization_path
    add_breadcrumb 'Wish List', user_profile_wish_list_path
    
    @dresses = current_user.dresses
  end
  
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
