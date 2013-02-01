class ProfilesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  
  def new
  	@profile = Profile.new
  end

  def show
    @profile = Profile.find(params[:id])
    authorized = Relationship.exists?(:profile_id => @profile.id , :user_id => current_user.id)

    #
    # privacy == 2 means that only related family and friends can view and post in profile
    #
    if @profile.privacy == 2 and not authorized
      flash[:error] = "You are not authorized to view that profile"
      redirect_to root_url
    else
      store_location
      @memory = @profile.memories.build if signed_in?
      @memoryfeed_items = @profile.memoryfeed.paginate(page: params[:page])
    end
  end

  def create
  	@profile = Profile.new(params[:profile])
   
  	if @profile.save
      current_user.contribute!(@profile, params[:relationship][:description], true)
  		flash[:success] = "Welcome to the HaloLane App!"
  		redirect_to @profile
  	else
  		render 'new'
  	end
  end

end
