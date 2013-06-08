module EasyAuth::Models::Identities::Oauth2::Google
  def account_attributes_map
    { :email => 'email', :first_name => 'given_name', :last_name => 'family_name', :name => 'name' }
  end

  def authorize_url
    '/o/oauth2/auth'
  end

  def oauth2_scope
    'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
  end

  def user_info_url
    'https://www.googleapis.com/oauth2/v1/userinfo'
  end

  def token_url
    '/o/oauth2/token'
  end

  def site_url
    'https://accounts.google.com'
  end

  def retrieve_uid(user_info)
    user_info['email']
  end
end
