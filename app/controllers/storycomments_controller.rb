class StorycommentsController < ApplicationController
	def new
    @page = Page.new
    
  end

  def create
    @storycomment = current_user.storycomments.build(
    	:memory_id => params[:storycomment][:memory_id],
    	:content => (params[:storycomment][:content]).strip)
		@memory = Memory.find(params[:storycomment][:memory_id])
		@profile = Profile.find(@memory.profile_id)
		@page = Page.find(@memory.page_id)
		@chapter = Chapter.find(@page.chapter_id)
    respond_to do |format|
      if @storycomment.save
        format.js
        format.json { render json: @storycomment, status: :created, location: @storycomment }
      else
        format.html { redirect_to root_url + @profile.url + "/chapter/" + @chapter.chapter_num.to_s  }
        format.json { render json: @storycomment.errors, status: :unprocessable_entity }
      end
    end
  end
end