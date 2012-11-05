require 'spec_helper'

feature 'Google OAuth Authentication', :js do
  use_vcr_cassette 'google_oauth', :match_requests_on => [:uri]

  scenario 'Google link redirects to the Google OAuth url' do
    visit root_path

    click_link 'Google'
    current_url.should match /^https:\/\/accounts.google.com\//
  end

  scenario 'Handling a google callback' do
    visit oauth2_callback_path(:provider => :google, :code => 'test-auth-code')

    current_path.should eq dashboard_path
    page.should have_content '123456789'
  end
end
