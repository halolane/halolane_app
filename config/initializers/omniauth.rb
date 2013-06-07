Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
  	provider :facebook, '600234840002738', 'ed2b0f88f0511d28ebd728c3a41dec15'
  else
  	provider :facebook, '250081775126133', 'cb2b072136a657b523113925a0cc4829'
  end
  
end