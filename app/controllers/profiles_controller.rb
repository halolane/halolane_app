class ProfilesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  
  def new
  	@profile = Profile.new
  end

  def show
    if params[:url] != nil
      @profile = Profile.find_by_url(params[:url])
    else
      @profile = Profile.find(params[:id])
    end
    
    @invitation = Invitation.find_by_token(params[:invitation_token])
    #@profile = Profile.find_by_id(params[:id])
    
    #
    # privacy == 2 means that only related family and friends can view and post in profile
    #
    #if @profile != nil 
      if ( @profile.privacy != 2 ) or 
         ( @profile.privacy == 2 and signed_in? and has_relationship?(@profile.id, current_user.id) )
        showprofile
      elsif is_invited?(params[:invitation_token]) and @invitation.active == true
        createnewuser
        showprofile
      elsif is_invited?(params[:invitation_token]) and @invitation.active == false
        flash[:error] = "The invitation link has expired."
        redirect_to root_url
      else
        flash[:error] = "You are not authorized to view that profile"
        redirect_to root_url
      end
    #else
     # flash[:error] = "The life storybook you were looking for was not found"
      #redirect_to root_url
    #end
  end

  def create
  	@profile = Profile.new(params[:profile])
    newurl = @profile.first_name.downcase + @profile.last_name.downcase
    i = 0
    while Profile.exists?(newurl) do
      i = i + 1
      newurl = newurl + i.to_s
    end

    @profile.url = newurl

   
  	if @profile.save
      current_user.contribute!(@profile, params[:relationship][:description], true)
  		flash[:success] = "Welcome to the HaloLane App!"
  		redirect_to root_url + @profile.url
  	else
  		render 'new'
  	end
  end

  private

    def showprofile
      store_location
      if signed_in? or is_invited?(params[:invitation_token])
        @memory = @profile.memories.build 
        @invitation = @profile.invitations.build
      end
      @memoryfeed_items = @profile.memoryfeed.paginate(page: params[:page])
    end

    def createnewuser
      @invitation = Invitation.find_by_token(params[:invitation_token])
      temppassword = rand(999999).to_s.center(6, rand(9).to_s)
      @user = User.new(email: @invitation.recipient_email, first_name: "Guest",
        last_name: "User",
        password: temppassword, password_confirmation: temppassword )
      @user.save
      @invitation.toggle!(:active)
      sign_in @user
    end
end
