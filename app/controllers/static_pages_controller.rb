class StaticPagesController < ApplicationController
  def home
  	@user = User.new
  	@profile = Profile.new

    if signed_in?
      render :layout => "application"
    else
      render :layout => "home_layout"
    end
    
  	if signed_in? 
  		@user = current_user
  		@profiles = @user.profiles_with_relationships.paginate(page: params[:page])
  		@memory = current_user.memories.build 
  	end
  	
  end

  def about
  end
end
