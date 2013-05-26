class RelationshipsController < ApplicationController
   before_filter :signed_in_user, only: [:index, :destroy, :edit, :create]

  def new
    @relationship = Relationship.new
  end

  def create
    @relationship = Relationship.new(params[:relationship])
  end

  def edit 
    @relationship = Relationship.find(params[:id])
    @profile = Profile.find_by_id(@relationship.profile_id)
  end

  def update 
    @relationship = Relationship.find(params[:id])
    @profile = Profile.find_by_id(@relationship.profile_id)
    @relationship.description = params[:relationship][:description]
    if @relationship.save
      redirect_to root_url + @profile.url, notice: "Your relationship to " + @profile.first_name + " has been updated"
    else
      flash[:error] = "Please enter the missing fields."
      redirect_to edit_relationship_path(@relationship)
    end
  end
  
  def destroy
    @relationship.destroy
    redirect_back_or root_url
  end
end
