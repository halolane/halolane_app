Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
  	provider :facebook, '213543968797507', 'adb90bb23d1c50e9b2518570946fea10'
  else
  	provider :facebook, '388701887900457', '7f6b6645f2d21310d004597f92d7a963'
  end
  
end