ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  fixtures :users
  fixtures :payments

  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  # Add more helper methods to be used by all tests here...

end