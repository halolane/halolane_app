Paperclip::Attachment.default_options.merge!(
	:storage => :s3,
	:s3_protocol => 'http',
	:s3_credentials => {
	    :bucket => ENV['AWS_BUCKET'],
	    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
	    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
	  }
)