class MemoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :edit]
  before_filter :correct_user,   only: :edit
  before_filter :set_page_name

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
        current_user.actionlog!(@profile.id, @page_name, "New memory created" )
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
      current_user.actionlog!(@profile.id, @page_name, "Memory updated" )
      redirect_to root_url + @profile.url
    else
      flash[:error] = "Please enter the missing fields."
      redirect_to edit_memory_path(@memory)
    end
  end

  
  def destroy
    begin 
      @memory = Memory.find_by_id(params[:id])
    rescue
      redirect_to root_url, notice: 'That story was not found.'
      return
    end

    if current_user.isEditor?(@memory.profile_id)
      @memory.destroy
    else
      begin 
         @memory = current_user.memories.find_by_id(params[:id])
         @memory.destroy
      rescue
        flash[:error] = "You don't have permission to delete this"
        redirect_back_or root_url
        return
      end
    end
    redirect_back_or root_url
  end

  private

    def set_page_name
      @page_name = "memories_controller"
    end
end
