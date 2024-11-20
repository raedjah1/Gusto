require_relative '../config/environment'
ENV['RAILS_ENV'] ||= 'test'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Add FactoryBot and Shoulda Matchers configurations (if using them)
RSpec.configure do |config|
  # Ensure ActiveRecord is defined and properly set up
  if defined?(ActiveRecord::Base)
    # Set fixture path to pluralized version to avoid Rails 7.1+ deprecation warning
    config.fixture_paths = ["#{::Rails.root}/spec/fixtures"]
  end

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Include FactoryBot syntax to simplify calls to factories
  config.include FactoryBot::Syntax::Methods if defined?(FactoryBot)

  # Shoulda Matchers configuration
  Shoulda::Matchers.configure do |with|
    with.integrate do |config|
      config.test_framework :rspec
      config.library :rails
    end
  end

  # Include Devise helpers for tests
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Faker setup (if needed for locale or configuration)
  Faker::Config.locale = 'en-US' # Set Faker locale for consistent data generation
end