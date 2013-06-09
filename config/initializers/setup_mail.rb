ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.default_url_options = { :host => 'www.familytales.co' }  

ActionMailer::Base.smtp_settings = {  
	:enable_starttls_auto => true,
	:address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => '587',
  :authentication       => "plain",
  :user_name            => "hello@familytales.co",  
  :password             => "IVEYmba2013"
}  