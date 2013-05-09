class Mailer < ActionMailer::Base
  default from: "info@familytales.co"

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
    subject = @user.first_name + " " + @user.last_name + " had invited you to the view life storybook of " + full_name
    @url = url
    mail( :from => 'info@familytales.co', 
          :to => @user.email, 
          :subject => subject )
    invitation.update_attribute(:sent_at, Time.now)
  end

  def validate_account(user, url)
    @user = user
    @url = url
    mail(:from => 'info@familytales.co', :to => @user.email , :subject => 'Welcome to FamilyTales')
  end
end
