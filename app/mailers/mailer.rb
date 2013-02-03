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
    
    @url = url
    mail(:to => "rsolidum@gmail.com" , :subject => 'HaloLane invitation')
    invitation.update_attribute(:sent_at, Time.now)
  end
end
