ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.default_url_options = { :host => 'www.familytales.co' }  

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {  
	:address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'familytales.co',
  :user_name            => 'hello@familytales.co', 
  :password             => 'IVEYmba2013',
  :authentication       => 'plain',
  :enable_starttls_auto => true  
}  

