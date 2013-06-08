require 'spec_helper'

feature 'Google OAuth Authentication', :js, :vcr do
  scenario 'Google link redirects to the Google OAuth url' do
    visit root_path

    click_link 'Google'
    current_url.should match /^https:\/\/accounts.google.com\//
  end

  scenario 'Handling a google callback' do
    visit oauth2_callback_path(:provider => :google, :code => 'test-auth-code')

    current_path.should eq dashboard_path
    page.should have_content 'test@example.com'
  end
end
