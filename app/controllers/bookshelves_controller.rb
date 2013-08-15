class BookshelvesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :edit, :update, :destroy, :show]
  before_filter :correct_user,   only: [:edit, :update]
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
    if signed_in?
      @user = current_user
      @profile = Profile.new
      @invitation = Invitation.new
      @memories = @user.memories.paginate(page: params[:page])
      @invited_books = @user.getinvitedbooks
      @bookshelves = @user.bookshelves_with_bookshelfrelations.paginate(page: params[:page])
      @memory = current_user.memories.build 
      current_user.actionlog!("", @page_name, "Logged-in user views family tree home" )
      render :layout => "bookshelf_layout"
    else
      @user = User.new
      render :layout => "home_layout"
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
    respond_to do | format |
      format.js 
      format.html { redirect_to root_url } 
    end
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
        format.js 
        format.html { redirect_to root_url }
      else
        format.html { redirect_to root_url }
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

  private 

    def correct_user
    @bookshelf = current_user.bookshelves.find(params[:id])
    rescue
      if Bookshelfrelation.find_by_bookshelf_id_and_user_id(@bookshelf.id, current_user.id).permission != "edit"
        flash[:error] = "You are not allowed to delete that storybook"
        redirect_to root_url
      end
    end
end
