class MemoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    
    @profile = Profile.find(params[:memory][:profile_id])
    authorized = Relationship.exists?(:profile_id => @profile.id , :user_id => current_user.id)
    @memory = current_user.memories.build(:profile_id => @profile.id, 
        :photo => params[:memory][:photo],
        :content => params[:memory][:content]) 
    
    respond_to do | format |   
      if @memory.save
        format.html { redirect_to root_url + @profile.url, notice: 'Post was successfully updated.' } 
        format.json { render json: @profile, status: :created, location: @profile }
        format.js 
      else
        format.html { redirect_to root_url + @profile.url, notice: 'Unable to load memory.' } 
      end
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
