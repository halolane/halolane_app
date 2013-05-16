class ProfilesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  
  def new
  	@profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    relationship = params[:relationship][:description]
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Storybook updated"
      current_user.updateRelationship!(@profile, relationship)
      redirect_back_or @profile
    else
      redirect_to edit_profile_path(@profile)
    end
  end

  def show

    if params[:url] != nil
      @profile = Profile.find_by_url(params[:url])
    else
      @profile = Profile.find(params[:id])
    end


    if params[:url] == "favicon"
      redirect_back_or root_url
    else
      if params[:invitation_token] != nil
        @invitation = Invitation.find_by_token(params[:invitation_token])
        if is_invited?(params[:invitation_token]) and @invitation.active == true
          createnewuser
          showprofile
          render :layout => "storyboard_layout"
        elsif is_invited?(params[:invitation_token]) and @invitation.active == false
          flash[:error] = "The invitation link has expired."
          redirect_to root_url
        else
          flash[:error] = "You are not authorized to view that profile"
          redirect_to root_url
        end
      elsif (( @profile.privacy != 2 ) or 
         ( @profile.privacy == 2 and signed_in? and has_relationship?(@profile.id, current_user.id) ))
        showprofile
        render :layout => "storyboard_layout"
      else
        flash[:error] = "You are not authorized to view that profile"
        redirect_to root_url
      end
    end
  end

  def create

    if params[:profile][:birthday] == nil
      @profile = Profile.new(first_name: params[:profile][:first_name], last_name: params[:profile][:last_name], birthday: 70.years.ago, deathday: Date.today, privacy: 2)
    else
    	@profile = Profile.new(params[:profile])
    end

    relationship = params[:relationship][:description]

  	if @profile.save
      current_user.contribute!(@profile, relationship, true)
  		flash[:success] = "Welcome to the HaloLane! We sent you an email to validate your account."
  		redirect_to root_url + @profile.url
  	else
  		render 'new'
      edit_memory_path(@profile)
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
      Mailer.validate_account(current_user, root_url + "login/" + current_user.token).deliver
      @user.contribute!(@profile, "1", false)
    end
end
