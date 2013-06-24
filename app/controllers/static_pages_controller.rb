class StaticPagesController < ApplicationController
  before_filter :set_page_name

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
      @user = current_user
      @profile = Profile.new
      @invitation = Invitation.new
      @memories = @user.memories.paginate(page: params[:page])
      @invited_books = @user.getinvitedbooks
      @bookshelves = @user.bookshelves_with_bookshelfrelations.paginate(page: params[:page])
      @memory = current_user.memories.build 
      current_user.actionlog!("", @page_name, "Logged-in user views family tree home" )
      render :layout => "bookshelf_layout"
    else
      @user = User.new
      render :layout => "home_layout"
    end
    
  end

  def about
    @user = User.new
    render :layout => "home_layout"
  end

  private

    def set_page_name
      @page_name = "static_pages_controller"
    end

end