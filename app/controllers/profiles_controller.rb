class ProfilesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  
  def new
  	@profile = Profile.new
  end

  def show
    store_location
  	@profile = Profile.find(params[:id])
    @memory = @profile.memories.build if signed_in?
    @memoryfeed_items = @profile.memoryfeed.paginate(page: params[:page])
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
