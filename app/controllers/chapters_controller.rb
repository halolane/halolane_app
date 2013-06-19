class ChaptersController < ApplicationController

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/new
  # GET /chapters/new.json
  def new
    @chapter = Chapter.new
  end

  # GET /chapters/1/edit
  def edit
    @chapter = Chapter.find(params[:id])

    respond_to do | format |
      format.js 
      format.html { redirect_to root_url + @profile.url } 
    end
  end

  def create
    @profile = Profile.find_by_id(params[:chapter][:profile_id])
    @chapter = @profile.createchapter!(params[:chapter][:chapter_name])
    puts @chapter.id
    puts "Chapter name: " + @chapter.chapter_name
    respond_to do | format |
      if not @chapter.nil?
        format.js 
        format.html { redirect_to root_url + @profile.url } 
      else
        format.html { redirect_to root_url + @profile.url } 
      end
    end
  end

  def update
    begin 
      @chapter = Chapter.find(params[:id])
    rescue
      redirect_to root_url, notice: 'That chapter was not found.'
      return
    end

    @profile = Profile.find(@chapter.profile_id)

    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        format.js 
        format.html { redirect_to root_url + @profile.url, notice: 'Chapter was successfully updated.' }
      else
        format.html { redirect_to root_url + @profile.url, notice: 'Not able to edit the chapter' }
      end
    end
  end

  def destroy
    begin 
      @chapter = Chapter.find(params[:id])
    rescue
      redirect_to root_url, notice: 'That chapter was not found.'
      return
    end

    @profile = Profile.find(@chapter.profile_id)
    if current_user.isEditor?(@chapter.profile_id)
      @chapter.destroy
      redirect_to root_url + @profile.url
    else
      flash[:error] = "You don't have permission to delete this"
      redirect_to root_url + @profile.url
    end
    
    # respond_to do |format|
    #   format.html { redirect_to chapters_url }
    #   format.json { head :no_content }
    # end
  end
end
