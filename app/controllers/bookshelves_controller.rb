class BookshelvesController < ApplicationController
  # GET /bookshelves
  # GET /bookshelves.json
  def index
    @bookshelves = Bookshelf.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookshelves }
    end
  end

  # GET /bookshelves/1
  # GET /bookshelves/1.json
  def show
    @bookshelf = Bookshelf.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookshelf }
    end
  end

  # GET /bookshelves/new
  # GET /bookshelves/new.json
  def new
    @bookshelf = Bookshelf.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookshelf }
    end
  end

  # GET /bookshelves/1/edit
  def edit
    @bookshelf = Bookshelf.find(params[:id])
  end

  # POST /bookshelves
  # POST /bookshelves.json
  def create
    @bookshelf = Bookshelf.new(params[:bookshelf])

    respond_to do |format|
      if @bookshelf.save
        format.html { redirect_to @bookshelf, notice: 'Bookshelf was successfully created.' }
        format.json { render json: @bookshelf, status: :created, location: @bookshelf }
      else
        format.html { render action: "new" }
        format.json { render json: @bookshelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookshelves/1
  # PUT /bookshelves/1.json
  def update
    @bookshelf = Bookshelf.find(params[:id])

    respond_to do |format|
      if @bookshelf.update_attributes(params[:bookshelf])
        format.html { redirect_to @bookshelf, notice: 'Bookshelf was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookshelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookshelves/1
  # DELETE /bookshelves/1.json
  def destroy
    @bookshelf = Bookshelf.find(params[:id])
    @bookshelf.destroy

    respond_to do |format|
      format.html { redirect_to bookshelves_url }
      format.json { head :no_content }
    end
  end
end
