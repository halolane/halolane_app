class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    
    if authentication
      @user = User.find(authentication.user.id)
      sign_in @user
      flash[:notice] = "Signed in successful."
      redirect_to @user
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      temppassword = rand(999999).to_s.center(6, rand(9).to_s)
      @user = User.new(email: omniauth['info']['email'],
                      first_name: omniauth['info']['first_name'],
                      last_name: omniauth['info']['last_name'],
                      password: temppassword,
                      password_confirmation: temppassword )
      if @user.save
        @user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
        flash[:notice] = "Signed in successful."
        sign_in @user
        redirect_to user_path(@user)
      else
        flash[:notice] = "Signed in failed."
        redirect_to root_url
      end
    end
  end

  def show

  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
