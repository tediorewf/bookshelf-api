require 'test_helper'

class Api::V1::TokenControllerTest < ActionDispatch::IntegrationTest
  test 'should create token for existing user' do
    email = 'email@example.com'
    password = 'password'
    params = {
      user: {
        email: email,
        password: password
      }
    }
    _ = User.create(params[:user].merge({password_confirmation: 'password'}))

    post api_v1_token_path params: params

    assert_response :created
  end

  test 'should not create token for non existing user' do
    email = 'non-existing-user-email@example.com'
    password = 'non-existing-user-password'
    params = {
      user: {
        email: email,
        password: password
      }
    }

    post api_v1_token_path params: params

    assert_response :unprocessable_entity
  end

  test 'should not create token with wrong password' do
    email = 'email@example.com'
    password = 'fake-password'
    params = {
      user: {
        email: email,
        password: password
      }
    }
    _ = User.create(email: email,
                    password: 'password',
                    password_confirmation: 'password')

    post api_v1_token_path params: params

    assert_response :unprocessable_entity
  end
end
