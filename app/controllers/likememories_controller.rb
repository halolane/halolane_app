class LikememoriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy ]

  def new
    @likememory = Likememory.new
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

  # DELETE /likememories/1
  # DELETE /likememories/1.json
  def destroy
    @likememory = Likememory.find(params[:id])
    @likememory.destroy
  end
end
