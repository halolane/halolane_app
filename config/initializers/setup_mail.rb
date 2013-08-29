ActionMailer::Base.raise_delivery_errors = true

# ActionMailer::Base.default_url_options = { :host => 'www.thefamilytales.com' }  

ActionMailer::Base.delivery_method = :smtp
if Rails.env.production?
	ActionMailer::Base.smtp_settings = {  
		:address =>        'smtp.mandrillapp.com',
	  :port                 => 587,
	  :user_name =>      ENV['MANDRILL_USERNAME'],
	    :password =>       ENV['MANDRILL_APIKEY'],
	  :authentication       => 'plain',
	  :enable_starttls_auto => true  
	}  
else 
	ActionMailer::Base.smtp_settings = {  
		:address              => "smtp.gmail.com",
	  :port                 => 587,
	  :domain               => 'thefamilytales.com',
	  :user_name            => 'hello@thefamilytales.com', 
	  :password             => 'IVEYmba2013',
	  :authentication       => 'plain',
	  :enable_starttls_auto => true  
	}  
end

