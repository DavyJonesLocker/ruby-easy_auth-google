file 'config/database.yml', :force => true do
<<-CONFIG
test:
  adapter: postgresql
  encoding: unicode
  database: easy_auth-angel_list_test
  pool: 5
  username: <%= ENV['DB_USERNAME'] || 'postgres' %>
  password:
  min_messages: warning
development:
  adapter: postgresql
  encoding: unicode
  database: easy_auth-angel_list_development
  pool: 5
  username: <%= ENV['DB_USERNAME'] || 'postgres' %>
  password:
  min_messages: warning
CONFIG
end

inside (ENV['DUMMY_APP_PATH'] || 'spec/dummy') do
  rake('db:drop')
end

generate('easy_auth:setup')
generate(:model, 'user email:string -t false')
generate(:controller, 'sessions -t false --no_helper --no_assets')
generate(:controller, 'landing show -t false --no_helper --no_assets')
generate(:controller, 'dashboard show -t false --no_helper --no_assets')

insert_into_file 'config/initializers/easy_auth.rb', :after => "  # put your config options in here\n" do
  "  c.oauth2_client :google, '%s', '%s'\n" % [ ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET'] ]
end

insert_into_file 'app/models/user.rb', :after => "class User < ActiveRecord::Base\n" do
  "  include EasyAuth::Models::Account\n"
end

insert_into_file 'app/controllers/application_controller.rb', after: "ActionController::Base\n" do
  "  include EasyAuthHelper\n\n"
end

gsub_file 'app/controllers/dashboard_controller.rb', /ApplicationController/, 'AuthenticatedController'

insert_into_file 'app/controllers/landing_controller.rb', after: "class LandingController < ApplicationController\n" do
  "  before_filter :redirect_to_dashboard_if_signed_in\n\n"
end

insert_into_file 'app/controllers/landing_controller.rb', after: "\n  end\n" do
<<-RUBY
  private

  def redirect_to_dashboard_if_signed_in
    redirect_to(dashboard_show_url) if user_signed_in?
  end
RUBY
end

insert_into_file 'app/controllers/sessions_controller.rb', after: "class SessionsController < ApplicationController\n" do
<<-RUBY
  include EasyAuth::Controllers::Sessions

  private

  def after_successful_sign_in_url
    main_app.dashboard_show_url
  end
RUBY
end

create_file 'app/views/dashboard/show.html.erb', :force => true do
  "<%= current_user.email %>\n"
end

create_file 'app/views/landing/show.html.erb', :force => true do
<<-RUBY
<p>
  <%= link_to 'Google', oauth2_sign_in_path(:provider => :google) %>
</p>
RUBY
end

route 'easy_auth_routes'
route "root :to => 'landing#show'"
