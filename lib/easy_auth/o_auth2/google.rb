require 'easy_auth/google/engine'

module EasyAuth
  def self.o_auth2_google_identity_model(controller)
    EasyAuth::Identities::OAuth2::Google
  end

  module OAuth2::Google
    extend ActiveSupport::Autoload
    autoload :Controllers
  end

  module Controllers::Sessions
    include EasyAuth::OAuth2::Google::Controllers::Sessions
  end

  module Models::Identities::OAuth2
    autoload :Google
  end
end
