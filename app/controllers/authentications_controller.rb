class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    @user_check = User.find_by_email(omniauth['info']['email'])
    if authentication
      @user = User.find(authentication.user.id)
      sign_in @user
      flash[:success] = "Hi " + @user.first_name + "! Welcome back to FamilyTales."
      redirect_to root_url
    elsif @user_check
      sign_in @user_check
      @user_check.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:success] = "Hi " + @user_check.first_name + "! Welcome back to FamilyTales."
      redirect_to root_url
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to root_url
    else
      temppassword = rand(999999).to_s.center(6, rand(9).to_s)
      @user = User.new(email: omniauth['info']['email'],
                      first_name: omniauth['info']['first_name'],
                      last_name: omniauth['info']['last_name'],
                      password: temppassword,
                      password_confirmation: temppassword )
      if @user.save
        sign_in @user
        @user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
        new_bookshelf_name = @user.last_name + " Family Bookshelf"
        new_bookshelf = @user.createbookshelf!(new_bookshelf_name) 
        flash[:success] = "Hi " + @user.first_name + "! Welcome to the FamilyTales! Please check your email " + @user.email + " to validate your account."
        
        begin
          Mailer.delay.validate_account(@user, root_url + "login/" + @user.token)
        rescue
          flash[:error] = "We had issues sending an email to " + @user.email + " Please provide a valid email."
        end

        redirect_to root_url
      else
        flash[:notice] = "Signup failed."
        redirect_to signup_url
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
