Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '600234840002738', 'ed2b0f88f0511d28ebd728c3a41dec15'
end