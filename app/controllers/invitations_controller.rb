class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    
    @profile = Profile.find_by_id(params[:invitation][:profile_id])
    @invitation = current_user.invitations.build(:profile_id => @profile.id )
    @invitation.recipient_email = params[:invitation][:recipient_email]
    @invitation.active = true
    @user_invited = User.find_by_email(params[:invitation][:recipient_email])

    # Need to verify account first
    if ! @user_invited.blank? and has_relationship?(@profile.id, @user_invited.id)
      redirect_to root_url + @profile.url, :notice => @invitation.recipient_email + " is already contributing to this FamilyTales storybook"
    elsif Invitation.exists?(:recipient_email => params[:invitation][:recipient_email],:profile_id => @profile.id)
      @invitation_resent = Invitation.find_by_recipient_email_and_profile_id(params[:invitation][:recipient_email], @profile.id)
      flash[:notice] = "Resending invitation to " + @invitation_resent.recipient_email
      Mailer.invitation(@invitation_resent, @profile, current_user, root_url + @profile.url + "/" + @invitation_resent.token).deliver
      redirect_to root_url + @profile.url, :notice => "Your invitation has been re-sent to " + @invitation_resent.recipient_email
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
    if ! @invitation.blank?
      @user_check = User.find_by_email(@invitation.recipient_email)
      @profile = Profile.find_by_id(@invitation.profile_id)
      @sender = User.find_by_id(@invitation.sender_id)
    end

    if @invitation.blank? or ! @invitation.active
      redirect_to root_url, :notice => "That invitation has expired."
    elsif @profile.blank?
      redirect_to root_url, :notice => "This storybook doesn't exists"
    elsif ! @user_check.blank? 
      if ! has_relationship?(@profile.id, @user_check.id)
        relationship = 1
        sign_in @user_check
        current_user.contribute!(@profile, relationship, false)
        @relationship = Relationship.find_by_user_id_and_profile_id(current_user.id, @profile.id)
        redirect_to edit_relationship_path(@relationship)
      else
        redirect_to root_url + @profile.url
      end
    else
      @user = User.new
    end
  end

end
