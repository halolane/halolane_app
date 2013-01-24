class MemoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @memory = current_user.memories.build(params[:memory])

    if @memory.save
      flash[:success] = "Memory created"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @memory.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @memory = current_user.memories.find_by_id(params[:memory])
      rescue
        redirect_to root_url
    end
end
