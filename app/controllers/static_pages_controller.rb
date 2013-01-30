class StaticPagesController < ApplicationController
  def home
  	@memory = current_user.memories.build if signed_in?
  end

  def about
  end
end
