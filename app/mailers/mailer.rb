class Mailer < ActionMailer::Base

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
    mail( :from => "\"FamilyTales\" <hello@thefamilytales.com>", 
          :to => @user_invited.email, 
          :subject => subject )
  end

  def invitation(invitation, profile, user, url, msg)
    @invitation = invitation
    @profile = profile
    @user = user
    @msg = msg
    @full_name = @profile.first_name + " "  + @profile.last_name
    subject = "Check out " + @full_name + "'s FamilyTales storybook that I created"
    @url = url
    mail( :from => "\"" + @full_user_name + "\" <hello@thefamilytales.com>", 
          :to => @invitation.recipient_email, 
          :subject => subject )
    @invitation.update_attribute(:sent_at, Time.now)
  end

  def customize_request(user, msg)
    @msg = msg
    @user = user
    @full_user_name =  @user.first_name + " " + @user.last_name 
    subject = @full_user_name + " requested the following customization"
    mail( :from => "\"New Customization\" <hello@thefamilytales.com>", 
          :to => "hello@thefamilytales.com", 
          :subject => subject )
  end

  def invitation_bookshelf(invitation, user, url, msg)
    @invitation = invitation
    @user = user
    @msg = msg
    @full_user_name =  @user.first_name + " " + @user.last_name 
    subject = "Check out the FamilyTales bookshelf that I created"
    @url = url
    mail( :from => "\"" + @full_user_name + "\" <hello@thefamilytales.com>", 
          :to => @invitation.recipient_email, 
          :subject => subject )
    @invitation.update_attribute(:sent_at, Time.now)
  end

  def new_storybook(user, profile, url)

    # Set up vars
    @profile = profile
    @user = user
    @url = url
    @email = "story+" + @profile.url + "@thefamilytales.com"

    #Temp file set up for the vcf
    # file_name = @profile.first_name + "_" + @profile.last_name + "_add_new_story_by_email.vcf"
    # tmp_file_name = "tmp/" + @profile.first_name + "_" + @profile.last_name + "_" + Time.now.strftime("%Y-%m-%d-%H%M%S") + ".vcf"
    # tmp_file = File.new(tmp_file_name, "w")
    # tmp_file.puts(@profile.get_vcf_file)
    # tmp_file.close
    
    # attachments[file_name] = File.read(tmp_file)
    full_name = @profile.first_name + " "  + @profile.last_name
    subject =  full_name + "'s FamilyTales storybook had been created!"
    mail( :from => "\"FamilyTales\" <hello@thefamilytales.com>", 
          :to => @user.email, 
          :subject => subject )
    File.delete (tmp_file_name)
  end

  def send_vcf(user, profile, url)

    # Set up vars
    @profile = profile
    @user = user
    @url = url
    @email = "story+" + @profile.url + "@thefamilytales.com"

    #Temp file set up for the vcf
    file_name = @profile.first_name + "_" + @profile.last_name + "_add_new_story_by_email.vcf"
    tmp_file_name = "tmp/" + @profile.first_name + "_" + @profile.last_name + "_" + Time.now.strftime("%Y-%m-%d-%H%M%S") + ".vcf"
    tmp_file = File.new(tmp_file_name, "w")
    tmp_file.puts(@profile.get_vcf_file)
    tmp_file.close
    
    attachments[file_name] = File.read(tmp_file)
    full_name = @profile.first_name + " "  + @profile.last_name
    subject =  "Add new stories by email to " + full_name + "'s FamilyTales storybook!"
    mail( :from => "\"FamilyTales\" <hello@thefamilytales.com>", 
          :to => @user.email, 
          :subject => subject )
    File.delete (tmp_file_name)
  end


  def receive_email_not_user(email,storybook_email)
    @email = email
    @storybook_email = storybook_email
    mail(:from => "\"FamilyTales\" <hello@thefamilytales.com>", :to => @email , :subject => "Start celebrating your family's stories today" )
  end

  def receive_email_storybook_error(email,storybook_email)
    @email = email
    @storybook_email = storybook_email
    mail(:from => "\"FamilyTales\" <hello@thefamilytales.com>", :to => @email , :subject => "Start celebrating your family's stories today" )
  end

  def receive_email_confirm(email,storybook_email,url)
    @email = email
    @storybook_email = storybook_email
    @url = url
    mail(:from => "\"FamilyTales\" <hello@thefamilytales.com>", :to => @email , :subject => "Your story has been saved" )
  end

  def receive_email_save_error(email,storybook_email)
    @email = email
    @storybook_email = storybook_email
    mail(:from => "\"FamilyTales\" <hello@thefamilytales.com>", :to => @email , :subject => "Unable to save your story" )
  end

  def validate_account(user, url)
    @user = user
    @url = url
    mail(:from => "\"Beatrice Law, FamilyTales\" <hello@thefamilytales.com>", :to => @user.email , :subject => 'Welcome to FamilyTales')
  end

  def resend_validation(user, url)
    @user = user
    @url = url
    mail(:from => "\"FamilyTales\" <hello@thefamilytales.com>", :to => @user.email , :subject => 'Confirm your FamilyTales account')
  end


end
