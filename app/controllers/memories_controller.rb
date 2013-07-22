class MemoriesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :signed_in_user, only: [:create, :destroy, :edit, :like]
  before_filter :correct_user,   only: :edit
  before_filter :set_page_name

  def create
    
    @profile = Profile.find(params[:memory][:profile_id])
    authorized = Relationship.exists?(:profile_id => @profile.id , :user_id => current_user.id)

    begin
      @memory = current_user.memories.build(:profile_id => @profile.id, 
        :photo => params[:memory][:photo],
        :content => (params[:memory][:content]).strip,
        :date => (params[:memory][:date]).to_date,
        :page_id => (params[:memory][:page_id]),
        :tile_num => (params[:memory][:tile_num]),
        :title => (params[:memory][:title]).strip,
        :has_photo => (params[:memory][:photo] != nil)) 
    rescue 
      @memory = current_user.memories.build(:profile_id => @profile.id, 
          :photo => params[:memory][:photo],
          :content => (params[:memory][:content]).strip,
          :date => Date.today, 
          :page_id => (params[:memory][:page_id]),
          :tile_num => (params[:memory][:tile_num]),
          :title => (params[:memory][:title]).strip,
          :has_photo => (params[:memory][:photo] != nil)) 
    end

    @page = Page.find_by_id(params[:memory][:page_id])
    @chapter = Chapter.find_by_id(@page.chapter_id)
    @template = @page.template
    @tile = @template.tiles.find_by_tile_num(params[:memory][:tile_num])

    respond_to do | format |   
      if @memory.save
        format.html { redirect_to root_url + @profile.url + "/chapter/" + @chapter.chapter_num.to_s + "/page/" + @page.page_num.to_s } 
        format.js 
        current_user.actionlog!(@profile.id, @page_name, "New story created" )
      else
        format.html { redirect_to root_url + @profile.url } 
        @error_msg = "Sorry, we're not able to save your story because of the following " + pluralize(@memory.errors.count, "error") + ":<ul>"
        @memory.errors.full_messages.each do |msg|
          @error_msg = @error_msg + "<li>" + msg + "</li>"
        end 
        @error_msg = @error_msg + "</ul>"
        format.js 
        format.json { render json: @memory, status: :created, location: @memory }
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

  def update_title 
    
    @new_tile = params[:memory][:question]
    respond_to do | format |   
        format.js 
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

    @profile = Profile.find(@memory.profile_id)
    @questions = StorybookQuestion.all
    @page = Page.find(@memory.page_id)
    @chapter = Chapter.find(@page.chapter_id) 

    if current_user.isEditor?(@profile) or current_user.memories.exists?(:id => params[:id])
      @memory.destroy
    else
        flash[:error] = "You don't have permission to delete this"
    end

    respond_to do |format|
      format.html { redirect_to root_url + @profile.url + "/chapter/" + @chapter.chapter_num.to_s + "/page/" + @page.page_num.to_s }
      format.js
      format.json { head :no_content }
    end
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
