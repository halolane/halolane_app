class MemoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :edit, :like]
  before_filter :correct_user,   only: :edit
  before_filter :set_page_name

  def create
    
    @profile = Profile.find(params[:memory][:profile_id])
    authorized = Relationship.exists?(:profile_id => @profile.id , :user_id => current_user.id)
    @memory = current_user.memories.build(:profile_id => @profile.id, 
        :photo => params[:memory][:photo],
        :content => params[:memory][:content],
        :date => params[:memory][:date]) 

    respond_to do | format |   
      if @memory.save
        format.html { render :layout => false } 
        format.js 
        current_user.actionlog!(@profile.id, @page_name, "New story created" )
      else
        format.html { render :layout => false} 
      end
    end    
  end

  def like 
    @memory = Memory.find(params[:id])
    @profile = Profile.find(@memory.profile_id)
    @likememory = current_user.likememory!(@memory)

    respond_to do | format |   
      if @likememory.save 
        format.html { redirect_to root_url + @profile.url } 
        format.js 
        current_user.actionlog!(@profile.id, @page_name, "User liked memory" )
      else
        format.html { redirect_to root_url + @profile.url, notice: 'Unable to like memory.' } 
      end
    end
  end

  def unlike 
    @memory = Memory.find(params[:id])
    @profile = Profile.find(@memory.profile_id)
    
    respond_to do | format |   
      if current_user.unlikememory!(@memory)
        format.html { redirect_to root_url + @profile.url } 
        format.js 
      else
        format.html { redirect_to root_url + @profile.url, notice: 'Unable to unlike memory.' } 
      end
    end
  end

  def zoomstory
    @memory = Memory.find(params[:id])
    @profile = Profile.find(@memory.profile_id)

    respond_to do | format |   
      format.html { redirect_to root_url + @profile.url } 
      format.js 
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

    def correct_user
      @memory = current_user.memories.find(params[:id])
    rescue
        redirect_to root_url
    end
end
