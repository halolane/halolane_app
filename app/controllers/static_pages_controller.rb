class StaticPagesController < ApplicationController
  def home
  	@memory = current_user.memories.build if signed_in?
  	#@memoryfeed_items = current_user.memoryfeed.paginate(page: params[:page])
  end

  def about
  end
end
