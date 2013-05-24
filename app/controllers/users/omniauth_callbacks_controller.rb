class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token
  
  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      @user.confirmed_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      @user.confirmed_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      redirect_to new_user_registration_url
    end
  end

  def google
    # You need to implement the method below in your model
    @user = User.find_for_google(env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      @user.confirmed_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.open:id_data"] = env["openid.ext1"]
      @user.confirmed_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      redirect_to new_user_registration_url
    end
  end

end
