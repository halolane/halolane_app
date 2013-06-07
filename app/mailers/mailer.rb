class Mailer < ActionMailer::Base
  default from: "\"FamilyTales\" <hello@familytales.co>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation_user_already(user_invited, profile, user, url)
    @user_invited = user_invited
    @profile = profile
    @user = user
    full_name = @profile.first_name + " "  + @profile.last_name
    subject = @user.first_name + " " + @user.last_name + " invites you to view the FamilyTales storybook of " + full_name
    @url = url
    mail( :from => "\"FamilyTales\" <hello@familytales.co>", 
          :to => @user_invited.email, 
          :subject => subject )
  end

  def invitation(invitation, profile, user, url)
    @invitation = invitation
    @profile = profile
    @user = user
    full_name = @profile.first_name + " "  + @profile.last_name
    subject = @user.first_name + " " + @user.last_name + " invites you to view the FamilyTales storybook of " + full_name
    @url = url
    mail( :from => "\"FamilyTales\" <hello@familytales.co>", 
          :to => @invitation.recipient_email, 
          :subject => subject )
    @invitation.update_attribute(:sent_at, Time.now)
  end

  def new_storybook(user, profile, url)
    @profile = profile
    @user = user
    @url = url
    @email = "story+" + @profile.url + "@familytales.co"
    full_name = @profile.first_name + " "  + @profile.last_name
    subject =  full_name + "'s FamilyTales storybook has been created!"
    mail( :from => "\"FamilyTales\" <hello@familytales.co>", 
          :to => @user.email, 
          :subject => subject )
  end


  def receive_email_not_user(email,storybook_email)
    @email = email
    @storybook_email = storybook_email
    mail(:from => "\"FamilyTales\" <hello@familytales.co>", :to => @email , :subject => "Start celebrating your family's stories today" )
  end

  def receive_email_storybook_error(email,storybook_email)
    @email = email
    @storybook_email = storybook_email
    mail(:from => "\"FamilyTales\" <hello@familytales.co>", :to => @email , :subject => "Start celebrating your family's stories today url" )
  end

  def receive_email_confirm(email,storybook_email,url)
    @email = email
    @storybook_email = storybook_email
    @url = url
    mail(:from => "\"FamilyTales\" <hello@familytales.co>", :to => @email , :subject => "Your story has been saved" )
  end

  def receive_email_save_error(email,storybook_email)
    @email = email
    @storybook_email = storybook_email
    mail(:from => "\"FamilyTales\" <hello@familytales.co>", :to => @email , :subject => "Unable to save your story" )
  end

  def validate_account(user, url)
    @user = user
    @url = url
    mail(:from => "\"FamilyTales\" <hello@familytales.co>", :to => @user.email , :subject => 'Welcome to FamilyTales')
  end

  def resend_validation(user, url)
    @user = user
    @url = url
    mail(:from => "\"FamilyTales\" <hello@familytales.co>", :to => @user.email , :subject => 'Confirm your FamilyTales account')
  end
end
