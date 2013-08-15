class EmailsubscriptionsController < ApplicationController
  # GET /emailsubscriptions
  # GET /emailsubscriptions.json
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
        if current_user.profiles.count == 1
          format.html { redirect_to root_url + current_user.profiles.first.url, notice: 'Email subcription was successfully updated.' }
        else 
          format.html { redirect_to library_url, notice: 'Email subcription was successfully updated.' }
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
end
