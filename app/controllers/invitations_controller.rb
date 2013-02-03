class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    
    @profile = Profile.find_by_id(params[:invitation][:profile_id])
    @invitation = current_user.invitations.build(:profile_id => @profile.id )
    @invitation.recipient_email = params[:invitation][:recipient_email]
    @invitation.active = true



    if is_a_user_already?(@invitation.recipient_email) 
      
      @user = User.find_by_email(@invitation.recipient_email)
      if has_relationship?(@profile.id, @user.id)
        flash[:error] = @invitation.recipient_email + " is already contributing to this HaloLane storybook"
        redirect_back_or root_url
      end
    else
      if @invitation.save
        Mailer.invitation(@invitation, @profile, current_user, root_url + @profile.url + "/" + @invitation.token).deliver
        flash[:success] = "Thank you, invitation sent"
        redirect_back_or root_url
      else
        redirect_back_or root_url
      end
    end
  end
end
