class PasswordResetsController < ApplicationController
  before_filter :set_page_name

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset 
      UserMailer.delay.password_reset(user, edit_password_reset_url(user.password_reset_token))
    end
    redirect_to resetsent_url
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
    if !@user
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    end
  end

  def confirm
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Your password has been reset!"
      redirect_to root_url
    else
      render :edit
    end
  end

  private

    def set_page_name
      @page_name = "password_reset_controller"
    end

end
