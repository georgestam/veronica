ENV['RAILS_ENV'] ||= 'test'

# ensure development assets don't interfere with test assets.
# system('rm -rf public/assets && bundle exec rake tmp:clear tmp:cache:clear assets:clean') || fail # XXX optimize then re-enable

if (RSpec.configuration.instance_variable_get :@files_or_directories_to_run) == ['spec']
  unless ENV['CODESHIP']
    require 'simplecov'
    SimpleCov.start 'rails' do
      add_filter 'app/mailer_previews'
      add_filter 'lib/generators'
    end
  end
end

require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'
require 'capybara/rails'
require 'capybara/rspec'

include SpecHelpers

ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!(allow_localhost: true)

Capybara.server_host = 'localhost' # no 127.0.0.1. Cleaner and FB expects it too
Capybara.server_port = Veronica::Application.port
Capybara.app_host = Rails.application.config.asset_host

Timecop.safe_mode = true

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.filter_rails_from_backtrace!
  config.include ActionView::Helpers::TranslationHelper
  config.include Warden::Test::Helpers, type: :feature
  config.infer_spec_type_from_file_location!
  config.render_views  
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation) # leave it clean for FactoryGirl
    FactoryGirl.lint
    DatabaseCleaner.clean_with(:truncation) # clean what FactoryGirl created
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = (example.metadata[:js] || example.metadata[:truncate]) ? :truncation : :transaction
    DatabaseCleaner.start
    Warden.test_mode!
  end
  
  config.before(:each, :js) do
    page.driver.browser.manage.window.resize_to(1920, 1200)
  end
  
  config.after(:each) do |example|
    assert_js_ok if example.metadata[:js] && !example.metadata[:skip_js_check]
    DatabaseCleaner.clean
    Warden.test_reset!
  end
  
  config.around :each, :js do |ex|
    ex.run_with_retry retry: (ci? ? 3 : 2), retry_wait: 3
  end

end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
