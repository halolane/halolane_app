class ProfilesController < ApplicationController
  def new
  	@profile = Profile.new
  end

  def show
  	@profile = Profile.find(params[:id])
  end

  def create
  	@profile = Profile.new(params[:profile])
  	if @profile.save
  		flash[:success] = "Welcome to the HaloLane App!"
  		redirect_to @profile
  	else
  		render 'new'
  	end
  end

end
