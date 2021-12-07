ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

module PasswordDigestHelper
  def password_digest(password)
    BCrypt::Password.create(password)
  end
end

module UserFixturesAttributes
  def user_one_id
    1
  end

  def user_one_email
    "one@one.one"
  end

  def user_one_password
    "one"
  end

  def user_two_id
    2
  end

  def user_two_email
    "two@two.two"
  end

  def user_two_password
    "two"
  end
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include UserFixturesAttributes
end

ActiveRecord::FixtureSet.context_class.include PasswordDigestHelper
ActiveRecord::FixtureSet.context_class.include UserFixturesAttributes
