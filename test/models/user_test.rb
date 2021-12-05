require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email and password" do
    user = User.new
    assert_not user.save, "Saved the user without the email and password"
  end

  test "should normalize email before save" do
    user = User.new(email: "TeSt@TeSt.TeSt", password: "Password123")
    user.save
    assert_equal "test@test.test", user.email, "Saved the user with unnormalized email"
  end
end
