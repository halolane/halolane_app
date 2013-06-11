class LikememoriesController < ApplicationController
  # GET /likememories
  # GET /likememories.json
  def index
    @likememories = Likememory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @likememories }
    end
  end

  # GET /likememories/1
  # GET /likememories/1.json
  def show
    @likememory = Likememory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @likememory }
    end
  end

  # GET /likememories/new
  # GET /likememories/new.json
  def new
    @likememory = Likememory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @likememory }
    end
  end

  # GET /likememories/1/edit
  def edit
    @likememory = Likememory.find(params[:id])
  end

  # POST /likememories
  # POST /likememories.json
  def create
    @likememory = Likememory.new(params[:likememory])

    respond_to do |format|
      if @likememory.save
        format.html { redirect_to @likememory, notice: 'Likememory was successfully created.' }
        format.json { render json: @likememory, status: :created, location: @likememory }
      else
        format.html { render action: "new" }
        format.json { render json: @likememory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /likememories/1
  # PUT /likememories/1.json
  def update
    @likememory = Likememory.find(params[:id])

    respond_to do |format|
      if @likememory.update_attributes(params[:likememory])
        format.html { redirect_to @likememory, notice: 'Likememory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @likememory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likememories/1
  # DELETE /likememories/1.json
  def destroy
    @likememory = Likememory.find(params[:id])
    @likememory.destroy

    respond_to do |format|
      format.html { redirect_to likememories_url }
      format.json { head :no_content }
    end
  end
end
