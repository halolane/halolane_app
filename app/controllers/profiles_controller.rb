class ProfilesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: [:edit, :update, :show]
  before_filter :can_edit, only: [:edit, :update]
  before_filter :set_page_name
  
  def new
  	@profile = Profile.new
  end

  def edit
    get_profile
  end

  def destroy
    get_profile

    if current_user.isOwner?(@profile) or current_user.isEditor?(@profile)
      @profile.destroy
    else
      flash[:error] = "You don't have permission to delete this"
    end
    redirect_to root_url
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

  def getvcf 
    @profile = Profile.find(params[:id])
    full_name = @profile.first_name + "_" + @profile.last_name + "_add_new_story_by_email"
    send_data @profile.get_vcf_file,
      :filename => "#{full_name}.vcf",
      :type => "text/plain"
    Mailer.delay.send_vcf(current_user, @profile, root_url + @profile.url)
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
    @chapter = Chapter.new
    if signed_in?
      @relationship = current_user.getRelationship(@profile)
    else
      @relationship = Relationship.new
    end

    if params[:url] == "favicon"
      redirect_back root_url
    else

      if ! signed_in? and @profile.url == "alexdunphy"
        @user = User.find_by_email('familytalesuser2@gmail.com')
        if ! @user.nil?
          sign_in @user
          showprofile
          redirect_to root_url + @profile.url
        else
          redirect_to root_url
        end
      elsif ! signed_in?
        flash[:error] = "You can only view that storybook if you are logged in."
        redirect_to login_url
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
      @profile = Profile.new(first_name: params[:profile][:first_name], last_name: params[:profile][:last_name], birthday: Date.today, deathday: Date.today, privacy: 2, bookshelf_id: params[:profile][:bookshelf_id])
    else
      @profile = Profile.new(first_name: params[:profile][:first_name], last_name: params[:profile][:last_name], birthday: (params[:profile][:birthday]).to_date , deathday: Date.today, privacy: 2, bookshelf_id: params[:profile][:bookshelf_id])
    end

    @relationship = params[:relationship][:description]

  	if @profile.save
      current_user.contribute!(@profile, @relationship, true, "edit", true)
      @profile.createchapter!('The beginning')
      current_user.actionlog!(@profile.id, @page_name, "create")
      Mailer.delay.new_storybook(current_user, @profile, root_url + @profile.url)
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

    def correct_user
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
      
      if @profile.url != "alexdunphy"
        redirect_to(root_path) unless (current_user.canView?(@profile))
      end
    end

    def can_edit
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
      
      redirect_to(root_path + @profile.url) unless (current_user.isEditor?(@profile))
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
      Mailer.delay.validate_account(current_user, root_url + "login/" + current_user.token)
      @user.contribute!(@profile, "1", false)
    end
end
