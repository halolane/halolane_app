ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "gmail.com",  
  :user_name            => "familytalesus@gmail.com",  
  :password             => "IVEYmba2013!",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  