class Mailer < ActionMailer::Base
  default from: "info@halolane.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation(invitation, profile, user, url)
    @invitation = invitation
    @profile = profile
    @user = user
    full_name = @profile.first_name + " "  + @profile.last_name
    subject = @user.first_name + " invites you in a digital life story book of " + full_name
    @url = url
    mail( :from => @user.email, 
          :to => @invitation.recipient_email, 
          :subject => subject )
    invitation.update_attribute(:sent_at, Time.now)
  end

  def validate_account(user, url)
    @user = user
    @url = url
    mail(:to => @user.email , :subject => 'Your temporary password to HaloLane')
  end
end
