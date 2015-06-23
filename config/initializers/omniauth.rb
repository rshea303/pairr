Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :github, ENV['github_key'], ENV['github_secret']
   provider :github, "8db69fa319cd68a814a0", "0114663e7acb0fcba9c605af92e304b5b2f5d068"
end
