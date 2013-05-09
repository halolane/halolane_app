class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    
    @profile = Profile.find_by_id(params[:invitation][:profile_id])
    @invitation = current_user.invitations.build(:profile_id => @profile.id )
    @invitation.recipient_email = params[:invitation][:recipient_email]
    @invitation.active = true

    # Need to verify account first
    if is_a_user_already?(@invitation.recipient_email) 
      
      @user = User.find_by_email(@invitation.recipient_email)
      if has_relationship?(@profile.id, @user.id)
        flash[:error] = @invitation.recipient_email + " is already contributing to this HaloLane storybook"
        redirect_back_or root_url
      else
        @user.contribute!(@profile, "1", false)
      end
    elsif email_is_invited?(@invitation.recipient_email)
      flash[:notice] = "Resending invitation to " + @invitation.recipient_email
      @invitation = Invitation.find_by_recipient_email(@invitation.recipient_email)
      Mailer.invitation(@invitation, @profile, current_user, root_url + @profile.url + "/" + @invitation.token).deliver
      redirect_back_or root_url    
    elsif @invitation.save
      Mailer.invitation(@invitation, @profile, current_user, root_url + @profile.url + "/" + @invitation.token).deliver
      flash[:success] = "Thank you, invitation sent"
      redirect_back_or root_url
    else
      flash[:error] = "Invalid Email"
      redirect_back_or root_url + @profile.url
    end
  end
end
