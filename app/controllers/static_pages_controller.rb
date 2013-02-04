class StaticPagesController < ApplicationController
  def home
  	@memory = current_user.memories.build if signed_in?
  	@user = User.new
  	@profile = Profile.new
  end

  def about
  end
end
