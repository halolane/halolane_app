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
        redirect_to root_url + @profile.url, :notice => @invitation.recipient_email + " is already contributing to this FamilyTales storybook"
      else
        @user.contribute!(@profile, 1, false)
        Mailer.invitation_user_already(@profile, current_user, root_url + @profile.url).deliver
        redirect_to root_url + @profile.url, :notice => "Your invitation has been sent to " + @invitation.recipient_email
      end
    elsif email_is_invited?(@invitation.recipient_email)
      flash[:notice] = "Resending invitation to " + @invitation.recipient_email
      @invitation_resent = Invitation.find_by_recipient_email(@invitation.recipient_email)
      Mailer.invitation(@invitation_resent, @profile, current_user, root_url + @profile.url + "/" + @invitation_resent.token).deliver
      redirect_to root_url + @profile.url, :notice => "Your invitation has been re-sent to " + @invitation.recipient_email
    elsif @invitation.save
      Mailer.invitation(@invitation, @profile, current_user, root_url + @profile.url + "/" + @invitation.token).deliver
      redirect_to root_url + @profile.url, :notice => "Your invitation has been sent to " + @invitation.recipient_email
    else
      flash[:error] = "Invalid Email"
      redirect_to root_url + @profile.url
    end
  end

  def show
    @invitation = Invitation.find_by_token(params[:invitation_token])
  end

end
