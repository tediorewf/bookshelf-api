require "test_helper"

class Api::V1::TokenControllerTest < ActionDispatch::IntegrationTest
  TOKEN_PROPERTY_NAME = 'token'
  private_constant :TOKEN_PROPERTY_NAME

  test "should create token for existing user" do
    email = user_one_email
    password = user_one_password
    params = {
      email: email,
      password: password
    }

    post api_v1_token_path params: params

    assert_response :created
    assert_not_nil response.body[TOKEN_PROPERTY_NAME]
  end

  test "should not create token for not existing user" do
    email = "not@existing.email"
    password = "not-existing-password"
    params = {
      email: email,
      password: password
    }

    post api_v1_token_path params: params

    assert_response :bad_request
    assert_nil response.body[TOKEN_PROPERTY_NAME]
  end
end
