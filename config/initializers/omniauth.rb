Rails.application.config.middleware.use OmniAuth::Builder do
 provider :github, ENV['7f82eced5ae0dd114780'], ENV['931f73d919c3a6f65eca28b178b8956eb7279c66']
end