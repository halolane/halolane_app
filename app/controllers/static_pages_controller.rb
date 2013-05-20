class StaticPagesController < ApplicationController
  def home

  	
    if signed_in?
      if not params[:verify_token] == nil
        @user = User.find_by_token(params[:verify_token])
        if @user.verified != true
          flash[:notice] = "Your email has been verified."
          @user.toggle!(:verified)
        end
        sign_in @user
      end
      @user = current_user
      @profile = Profile.new
      @memories = @user.memories.paginate(page: params[:page])
      @profiles = @user.profiles_with_relationships.paginate(page: params[:page])
      @memory = current_user.memories.build 
      render :layout => "application"
    else
      @user = User.new
      render :layout => "home_layout"
    end
  	
  end

  def about
  end
end
