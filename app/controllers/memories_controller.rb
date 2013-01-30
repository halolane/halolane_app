class MemoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @profile = Profile.find(params[:memory][:profile_id])
    @memory = current_user.memories.build(:content => params[:memory][:content], :profile_id => @profile.id ) 

    if @memory.save
      flash[:success] = "Memory created"
      redirect_back_or root_url
    else
      flash[:error] = "Content can't be blank"
      @memoryfeed_items = []
      redirect_back_or root_url
    end
  end
  
  def destroy
    @memory.destroy
    redirect_back_or root_url
  end

  private

    def correct_user
      @memory = current_user.memories.find_by_id(params[:memory])
      rescue
        redirect_to root_url
    end
end
