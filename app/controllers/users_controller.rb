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
    temppassword = rand(999999).to_s.center(6, rand(9).to_s)
    @user = User.new(email: params[:user][:email], first_name: "New",
        last_name: "User",
        password: temppassword, password_confirmation: temppassword )
    @user.verified = false

    @profile = Profile.new(first_name: params[:user][:profile][:first_name], last_name: params[:user][:profile][:last_name], birthday: 70.years.ago, deathday: Date.today, privacy: 2)
  
    if @user.save and @profile.save
      sign_in @user
      @user.contribute!(@profile, "1", true)
      Mailer.validate_account(current_user, root_url + "login/" + @user.token).deliver
      flash[:success] = "Welcome to the HaloLane App!"
      redirect_to root_url + @profile.url
    elsif @user.save and not @profile.save
      flash[:error] = "Sorry, we weren't able to save your storybook. Please fill in the following fields"
      redirect_to createstorybook_url
    elsif is_a_user_already?(params[:user][:email])
      flash[:error] = "The email " + params[:user][:email] + " is already registered. Please log in"
      redirect_to signin_url
    else
      flash[:error] = "Please fill out these fields"
      redirect_to root_url
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
        flash[:notice] = "Please change your password to validate your account."
      end
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      if @user.verified != true and params[:user][:password] != nil
        @user.toggle!(:verified)
        flash[:success] = "Account successfully validated"
      end
      sign_in @user
      redirect_back_or @user
    else
      render 'edit'
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
