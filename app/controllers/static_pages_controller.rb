class StaticPagesController < ApplicationController
  def home
  	
    if signed_in?
      @user = current_user
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
