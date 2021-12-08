require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user if correct params were sent" do
    email = "test@test.test"
    password = "password"
    password_confirmation = "password"
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :created
    assert_not_nil User.find_by_email(email)
  end

  test "should not create user which already exists" do
    email = user_one_email
    password = user_one_password
    password_confirmation = user_one_password
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }
    user_before_request = User.find_by_email(email)

    post api_v1_users_path, params: params

    user_after_response = User.find_by_email(email)
    assert_response :unprocessable_entity
    assert user_before_request == user_after_response
  end

  test "should not create user if empty params were sent" do
    params = {}

    post api_v1_users_path, params: params

    assert_response :bad_request
  end

  test "should not create user if params were contained invalid format email" do
    email = "not-an-email"
    password = "password"
    password_confirmation = "password"
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
    assert_nil User.find_by_email(email)
  end

  test "should not create user if password was too long" do
    email = "test@test.test"
    password = "very-long-password"*100
    password_confirmation = "very-long-password"*100
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
    assert_nil User.find_by_email(email)
  end

  test "should not create user if email was too long" do
    email = "test@test." + "test"*100
    password = "password"
    password_confirmation = "password"
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
    assert_nil User.find_by_email(email)
  end

  test "should not create user if password confirmation was not set" do
    email = "test@test.test"
    password = "password"
    params = {
      user: {
        email: email,
        password: password
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
    assert_nil User.find_by_email(email)
  end
end
