class StaticPagesController < ApplicationController
  before_filter :set_page_name
  before_filter :signed_in_user, only: [:welcome_one, :welcome_two]

  def home
    if not params[:verify_token] == nil
      @user = User.find_by_token(params[:verify_token])
      flash[:notice] = "Your email has been verified."
      if !@user.verified
        @user.toggle!(:verified)
      end
      sign_in @user
    end

    if signed_in? and current_user.email == ('familytalesuser2@gmail.com')
      sign_out
      @user = User.new
      render :layout => "home_layout"
    elsif signed_in?
      redirect_to library_url
    else
      @user = User.new
      render :layout => "home_layout"
    end
    
  end

  def welcome_one
    if signed_in?
      @user = current_user
      @profile = Profile.new
      render :layout => "bookshelf_layout"
    else
      @user = User.new
      redirect_to root_url
    end
  end

  def welcome_two
    if signed_in?
      @user = current_user
      @profile = Profile.new
      @emailsubscription = current_user.emailsubscription
      render :layout => "bookshelf_layout"
    else
      redirect_to root_url
    end
  end

  def billing
    if signed_in?
      @user = current_user
      @profile = Profile.new
      @emailsubscription = current_user.emailsubscription
      render :layout => "bookshelf_layout"
    else
      redirect_to root_url
    end
  end

  def error_page
  end

  def not_found
  end

  def privacy_policy
    
  end

  def about
    @user = User.new
    render :layout => "about_layout"
  end

  private

    def set_page_name
      @page_name = "static_pages_controller"
    end

end