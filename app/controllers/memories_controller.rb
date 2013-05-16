class MemoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :edit]
  before_filter :correct_user,   only: :destroy
  before_filter :correct_user,   only: :edit

  def create
    
    @profile = Profile.find(params[:memory][:profile_id])
    authorized = Relationship.exists?(:profile_id => @profile.id , :user_id => current_user.id)
    @memory = current_user.memories.build(:profile_id => @profile.id, 
        :photo => params[:memory][:photo],
        :content => params[:memory][:content]) 
    
    respond_to do | format |   
      if @memory.save
        format.html { redirect_to root_url + @profile.url, notice: 'Post was successfully updated.' } 
        format.js 
      else
        format.html { redirect_to root_url + @profile.url, notice: 'Unable to load memory.' } 
      end
    end    
  end

  def edit
    @memory = current_user.memories.find_by_id(params[:id])
    @profile = Profile.find_by_id(@memory.profile_id)
  end

  def update
    @memory = current_user.memories.find_by_id(params[:id])
    if @memory.update_attributes(params[:memory])
      @profile = Profile.find_by_id(@memory.profile_id)
      flash[:success] = "Memory updated"
      redirect_to root_url + @profile.url
    else
      flash[:error] = "Please enter the missing fields."
      redirect_to edit_memory_path(@memory)
    end
  end

  
  def destroy
    @memory = current_user.memories.find_by_id(params[:id])
    @memory.destroy
    redirect_back_or root_url
  end

  private

    def correct_user
     
      rescue
        redirect_to root_url
    end
end
