class UsersPasswordsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
		
		if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to welcome_path, :notice => "#{t('activerecord.successful.messages.updated', :model =>  @user.class.model_name.human)}"
    else
      render :edit
    end
  end
end
