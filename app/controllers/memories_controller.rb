class MemoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    
    @profile = Profile.find(params[:memory][:profile_id])
    authorized = Relationship.exists?(:profile_id => @profile.id , :user_id => current_user.id)
    
    if (@profile.privacy > 0 ) and not authorized
      flash[:error] = "You are not authorized to contribute to this profile"
    else
      @memory = current_user.memories.build(:profile_id => @profile.id, 
        :photo => params[:memory][:photo],
        :content => params[:memory][:content]) 

      if params[:memory][:photo] == nil and params[:memory][:content] == "" 
        flash[:error] = "Content and photo can't be blank"
      else 
        if @memory.save
          flash[:success] = "Memory created"
        else
          flash[:error] = "Content can't be blank"
          @memoryfeed_items = []
        end
      end
    end

    redirect_back_or root_url
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
