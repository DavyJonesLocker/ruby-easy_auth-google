require 'vcr'

VCR.configure do |c|
  c.ignore_request do |request|
    # Capybara requests
    URI(request.uri).port == 3999
  end
  c.hook_into :faraday
  c.cassette_library_dir = File.expand_path('../../cassettes', __FILE__)
  c.configure_rspec_metadata!
end
