class SessionsController < ApplicationController

  before_filter :set_page_name
	def new

	end

	def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      sign_in @user
      current_user.actionlog!("", @page_name, "User logged in" )
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def failure
  end

	def destroy
		sign_out
		redirect_to root_url
	end

  private 

    def set_page_name
      @page_name = "sessions_controller"
    end
end
