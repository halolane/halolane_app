class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :destroy]
  # before_filter :signed_in_user_or_invited(params[:verify_token]), only: [:edit, :update]
  before_filter :only => [:edit, :update] do |c| 
    c.signed_in_user_or_invited(params[:verify_token])
  end
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :set_page_name

  def show
    @profile = Profile.new
  	@user = User.find(params[:id])
    @profiles = @user.profiles_with_relationships.paginate(page: params[:page])

    @memories = @user.memories.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create    
    @user = User.new(email: params[:user][:email], 
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name],
      password: params[:user][:password], 
      password_confirmation: params[:user][:password] )
    if !params[:invitation].nil? && !params[:invitation][:token].nil?
      @invitation = Invitation.find_by_token(params[:invitation][:token])
      @profile = Profile.find_by_id(@invitation.profile_id)
      @user.invited_by = @invitation.sender_id
    end

    @user.verified = false
  
    if is_a_user_already?((params[:user][:email]).downcase)
      flash[:error] = "It looks like you already have an account on FamilyTales. Please enter your email and password here to login"
      redirect_to login_url
    elsif  @user.save 
      
      begin
        Mailer.validate_account(@user, root_url + "login/" + @user.token).deliver
      rescue
        flash[:error] = "We had issues sending an email to " + @user.email + " Please provide a valid email."
        @user.destroy
        redirect_to signup_url
        return
      end

      sign_in @user
      flash[:success] = "Welcome to the FamilyTales! Please check your email " + @user.email + " to validate your account."
      if params[:invitation].nil?
        redirect_to root_url
      else
        relationship = params[:relationship][:description]
        current_user.contribute!(@profile, relationship, @invitation.permission == "edit", @invitation.permission)
        if @invitation.active
          @invitation.toggle!(:active)
          current_user.actionlog!(@profile.id, @page_name, "New user accepts invitation to storybook" )
        end
        redirect_to root_url + @profile.url
      end
    else
      if params[:invitation].nil?
        flash[:error] = "Please fill out these fields"
        redirect_to signup_url
      else
        flash[:error] = "Please fill in all the fields"
        redirect_to root_url + @profile.url + "/" + @invitation.token
      end
    end
  end

  def resend_validation
    @user = current_user
    if !@user.verified 
      Mailer.resend_validation(current_user, root_url + "login/" + current_user.token).deliver
    else
      redirect_to root_url, :notice => "Your account has already been verified"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Account deleted."
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
    @profile = Profile.new
    @profiles = @user.profiles_with_relationships.paginate(page: params[:page])
    @memories = @user.memories.paginate(page: params[:page])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to root_url
    else
      redirect_to edit_user_path(current_user)
      flash[:error] = "Please enter the missing fields."
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end


  private

    def set_page_name
      @page_name = "user_controller"
    end

    def correct_user
      if params[:id] == nil
        @user = User.find_by_token(params[:verify_token])
      else
        @user = User.find(params[:id])
      end
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
