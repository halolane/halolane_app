class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset 
      UserMailer.password_reset(user, edit_password_reset_url(user.password_reset_token)).deliver
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
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
