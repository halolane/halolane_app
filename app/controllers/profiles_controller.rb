class ProfilesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :set_page_name
  
  def new
  	@profile = Profile.new
  end

  def edit
    get_profile
  end

  def update
    get_profile
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Storybook setting updated"
      current_user.actionlog!(@profile.id, @page_name, "update")
      redirect_to root_url + @profile.url
    else
      flash[:error] = "There was an error saving your changes"
      redirect_to edit_profile_path(@profile)
    end
  end

  def show

    if ! params[:url].blank?
      @profile = Profile.find_by_url(params[:url])
      if @profile.nil?
        show_error
        return
      end
    else
      begin
        @profile = Profile.find(params[:id])
      rescue
        show_error
        return
      end
    end

    if signed_in?
      @relationship = current_user.getRelationship(@profile)
    else
      @relationship = Relationship.new
    end

    if params[:url] == "favicon"
      redirect_back_or root_url
    else
      if params[:invitation_token] != nil
        @invitation = Invitation.find_by_token(params[:invitation_token])
        if is_invited?(params[:invitation_token]) and @invitation.active == true
          createnewuser
          showprofile
          current_user.actionlog!(@profile.id, @page_name, "show")
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
        if signed_in?
          current_user.actionlog!(@profile.id, @page_name, "show")
        end
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

    @relationship = params[:relationship][:description]

  	if @profile.save
      current_user.contribute!(@profile, @relationship, true, "edit")
      Mailer.new_storybook(current_user, @profile, root_url + @profile.url).deliver
      current_user.actionlog!(@profile.id, @page_name, "create")
  		redirect_to root_url + @profile.url
  	else
      flash[:error] = "Sorry, we're not able to create your storybook."
      redirect_to root_url
  	end
  end

  private

    def get_profile
      begin
        @profile = Profile.find(params[:id])
      rescue
        begin
          @profile = Profile.find_by_url(params[:id])
        rescue
         show_error
        end
      end
    end

    def show_error
      
      redirect_to root_url
    end

    def set_page_name
      @page_name = "storybook_controller"
    end

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
