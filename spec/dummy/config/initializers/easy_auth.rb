EasyAuth.config do |c|
  c.oauth2_client :google, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end
