class UsersController < ApplicationController
  def new
  end

  def show
  	@user = User.find(params[:id])
    @memories = @user.memories.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the HaloLane App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
end
