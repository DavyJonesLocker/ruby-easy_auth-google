EasyAuth.config do |c|
  c.oauth2_client :google, ENV['OAUTH_GOOGLE_CLIENT_ID'], ENV['OAUTH_GOOGLE_SECRET'], 'https://www.googleapis.com/auth/userinfo.profile'
end
