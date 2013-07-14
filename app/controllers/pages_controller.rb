class PagesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @chapter = Chapter.find(params[:page][:chapter_id])
    @profile = Profile.find(@chapter.profile_id)
    template_num = params[:page][:template_num]
    @page = @chapter.createpage!(template_num)
    @template = Template.find_by_template_num(template_num)
    @tiles = @template.tilelist
    @questions = StorybookQuestion.all
    respond_to do |format|
      if ! @page.nil?
        format.html { redirect_to root_url + @profile.url + "/chapter/" + @chapter.chapter_num.to_s + "/page/" + @chapter.pagecount.to_s, notice: 'New page created.'}
        format.js
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { redirect_to root_url + @profile.url + "/chapter/" + @chapter.chapter_num.to_s  }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @chapter = Chapter.find(@page.chapter_id)
    @profile = Profile.find(@chapter.profile_id)
    @page.destroy

    respond_to do |format|
      format.html { redirect_to root_url + @profile.url + "/chapter/" + @chapter.chapter_num.to_s, notice: "Page deleted"  }
      format.json { head :no_content }
    end
  end
end
