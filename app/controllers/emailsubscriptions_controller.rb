class EmailsubscriptionsController < ApplicationController
  # GET /emailsubscriptions
  # GET /emailsubscriptions.json
  before_filter :signed_in_user, only: [:edit, :update, :tellatale]
  before_filter :correct_user,   only: [:edit, :update]

  def index
    @emailsubscriptions = Emailsubscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emailsubscriptions }
    end
  end

  # GET /emailsubscriptions/1
  # GET /emailsubscriptions/1.json
  def show
    @emailsubscription = Emailsubscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emailsubscription }
    end
  end

  # GET /emailsubscriptions/new
  # GET /emailsubscriptions/new.json
  def new
    @emailsubscription = Emailsubscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emailsubscription }
    end
  end

  # GET /emailsubscriptions/1/edit
  def edit
    @emailsubscription = Emailsubscription.find(params[:id])
  end

  def tellatale
    @emailsubscription = current_user.emailsubscription
  end
  # POST /emailsubscriptions
  # POST /emailsubscriptions.json
  def create
    @emailsubscription = Emailsubscription.new(params[:emailsubscription])

    respond_to do |format|
      if @emailsubscription.save
        format.html { redirect_to @emailsubscription, notice: 'Emailsubscription was successfully created.' }
        format.json { render json: @emailsubscription, status: :created, location: @emailsubscription }
      else
        format.html { render action: "new" }
        format.json { render json: @emailsubscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emailsubscriptions/1
  # PUT /emailsubscriptions/1.json
  def update
    @emailsubscription = Emailsubscription.find(params[:id])

    respond_to do |format|
      if @emailsubscription.update_attributes(params[:emailsubscription])
        if @emailsubscription.emailperweek == 0
          format.html { redirect_to library_url, notice: 'You have been unsubscribed from Tell-a-Tales by Email.' }
        elsif current_user.memorycount == 0
          format.html { redirect_to root_url + current_user.profiles.first.url, notice: 'Awesome! You should start receiving FamilyTales\'s Tell-a-Tale questions about ' + current_user.profiles.first.first_name + ' by email in a few days.' }
          # format.html { redirect_to welcome_paymentinfo_path, notice: 'Awesome! You should start receiving FamilyTales\'s Tell-a-Tale questions about ' + current_user.profiles.first.first_name + ' by email in a few days.' }
        else 
          format.html { redirect_to library_url, notice: 'Your email subcription was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @emailsubscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emailsubscriptions/1
  # DELETE /emailsubscriptions/1.json
  def destroy
    @emailsubscription = Emailsubscription.find(params[:id])
    @emailsubscription.destroy

    respond_to do |format|
      format.html { redirect_to emailsubscriptions_url }
      format.json { head :no_content }
    end
  end

  private 
    def correct_user
      @emailsubscription = Emailsubscription.find(params[:id])
      @user = User.find(@emailsubscription.user_id)
      redirect_to(root_path) unless current_user?(@user)
    rescue
      redirect_to(root_path)
    end
end
