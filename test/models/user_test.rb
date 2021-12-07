require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email and password" do
    user = User.new
    saved = user.save

    assert_not saved, "Saved the user without the email and password"
  end

  test "should not save user without password confirmation" do
    email = "test@test.test"
    password = "password"
    attributes = {
      email: email,
      password: password
    }

    user = User.new(attributes)
    saved = user.save

    assert_not saved, "Saved the user without password confirmation"
  end

  test "should normalize email before save" do
    email = "TeSt@TeSt.TeSt"
    password = "password"
    password_confirmation = "password"
    attributes = {
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }

    user = User.new(attributes)
    _ = user.save

    assert_equal "test@test.test", user.email, "Saved the user with unnormalized email"
  end
end
