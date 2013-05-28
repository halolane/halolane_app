Paperclip::Attachment.default_options.merge!(
	:storage => :s3,
	:s3_protocol => 'http',
	:s3_credentials => {
		:bucket => ENV['familytales-prod'],
		:access_key_id => ENV['AKIAJ3AJTP2LJGWA6YPQ'],
		:secret_access_key => ENV['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']
	}
)