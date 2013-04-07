class StaticPagesController < ApplicationController
  def home
  	@user = User.new
  	@profile = Profile.new
    render :layout => "home_layout"
    
  	if signed_in? 
  		@user = current_user
  		@profiles = @user.profiles_with_relationships.paginate(page: params[:page])
  		@memory = current_user.memories.build 
  	end
  	
  end

  def about
  end
end
