require "test_helper"

class Api::V1::TokenControllerTest < ActionDispatch::IntegrationTest
  test "should create token for existing user" do
    email = user_one_email
    password = user_one_password
    params = {
      user: {
        email: email,
        password: password
      }
    }

    post api_v1_token_path params: params

    assert_response :created
  end

  test "should not create token for not existing user" do
    email = "not@existing.email"
    password = "not-existing-password"
    params = {
      user: {
        email: email,
        password: password
      }
    }

    post api_v1_token_path params: params

    assert_response :not_found
  end
end
