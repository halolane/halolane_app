class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :destroy]
  # before_filter :signed_in_user_or_invited(params[:verify_token]), only: [:edit, :update]
  before_filter :only => [:edit, :update] do |c| 
    c.signed_in_user_or_invited(params[:verify_token])
  end
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

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
    @user.verified = false
  
    # @profile = Profile.new(first_name: params[:user][:profile][:first_name], last_name: params[:user][:profile][:last_name], birthday: 70.years.ago, deathday: Date.today, privacy: 2)
    # relationship = params[:relationship][:description]
    # if @user.save and @profile.save
    if is_a_user_already?((params[:user][:email]).downcase)
      flash[:error] = "It looks like you already have an account on FamilyTales. Please enter your email and password here to login"
      redirect_to login_url
    elsif  @user.save 
      sign_in @user
      Mailer.validate_account(current_user, root_url + "login/" + current_user.token).deliver
      flash[:success] = "Welcome to the FamilyTales!"
      redirect_to root_url
      # redirect_to root_url + @profile.url
    # elsif @user.save and not @profile.save
    #   sign_in @user
    #   flash[:error] = "Sorry, we weren't able to save your storybook. Please fill in the following fields"
    #   Mailer.validate_account(current_user, root_url + "login/" + current_user.token).deliver
    #   redirect_to createstorybook_url
    # elsif is_a_user_already?(params[:user][:email])
    #   flash[:error] = "The email " + params[:user][:email] + " is already registered. Please log in"
    #   redirect_to signin_url
    else
      flash[:error] = "Please fill out these fields"
      redirect_to signup_url
    end
  end

  def send_password_reset 
    email = params[:user][:email]

    if is_a_user_already?(email.downcase)
      
    else
      flash[:error] = email + " is not a registered email on FamilyTales."
      redirect_to login_url
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
    if not params[:verify_token] == nil
      @user = User.find_by_token(params[:verify_token])
      if @user.verified != true
        flash[:notice] = "Your email has been verified."
        @user.toggle!(:verified)
      end
    else
      @user = User.find(params[:id])
    end
    @profile = Profile.new
    
    @profiles = @user.profiles_with_relationships.paginate(page: params[:page])

    @memories = @user.memories.paginate(page: params[:page])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      if @user.verified != true and params[:user][:password] != nil
        @user.toggle!(:verified)
        flash[:success] = "Account successfully validated"
      end
      sign_in @user
      redirect_back_or edit_user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
      flash[:error] = "Please enter the missing fields."
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end


  private

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
