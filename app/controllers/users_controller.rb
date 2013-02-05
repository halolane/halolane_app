class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
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

    @profile = Profile.new(first_name: params[:user][:profile][:first_name],
                           last_name: params[:user][:profile][:last_name],
                           birthday: 70.years.ago , 
                           deathday: Date.today ,
                           privacy: 2)
    
    newurl = (@profile.first_name.downcase + @profile.last_name.downcase).gsub(/ /,'')
    i = 0
    while Profile.exists?(newurl) do
      i = i + 1
      newurl = newurl + i.to_s
    end
    @profile.url = newurl
  
      
    if @user.save and @profile.save
      sign_in @user
      @user.contribute!(@profile, "1", true)
      flash[:success] = "Welcome to the HaloLane App!"
      redirect_to root_url + @profile.url
    elsif not @profile.save
      flash[:error] = "Unable to save storybook. Please fill in the following fields"
      redirect_to createstorybook_url
    else
      flash[:error] = "The email " + params[:user][:email] + " is already registered. Please log in"
      redirect_to signin_url
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end


  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
