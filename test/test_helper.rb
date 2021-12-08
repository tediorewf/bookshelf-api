ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

require "test_helpers/book_fixtures_attributes"
require "test_helpers/password_digest_helper"
require "test_helpers/user_fixtures_attributes"
require "test_helpers/token_helper"
require "test_helpers/reader_fixture_attributes"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include UserFixturesAttributes
  include TokenHelper
end

ActiveRecord::FixtureSet.context_class.include PasswordDigestHelper
ActiveRecord::FixtureSet.context_class.include UserFixturesAttributes
ActiveRecord::FixtureSet.context_class.include BookFixtureAttributes
ActiveRecord::FixtureSet.context_class.include ReaderFixtureAttributes
