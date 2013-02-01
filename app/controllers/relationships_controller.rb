class RelationshipsController < ApplicationController
 

  def new
    @relationship = Relationship.new
  end

  def create
    @relationship = Relationship.new(params[:relationship])
  end
  
  def destroy
    @relationship.destroy
    redirect_back_or root_url
  end
end
