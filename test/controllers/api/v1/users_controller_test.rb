require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should create user' do
    email = 'test@test.test'
    password = 'password'
    password_confirmation = 'password'
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :created
  end

  test 'should not create existing user' do
    email = 'test@test.test'
    password = 'password'
    password_confirmation = 'password'
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }
    _ = User.create(params[:user])

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
  end

  test 'should not create user with empty params' do
    params = {}

    post api_v1_users_path, params: params

    assert_response :bad_request
  end

  test 'should not create user with invalid format email' do
    email = 'not-an-email'
    password = 'password'
    password_confirmation = 'password'
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
  end

  test 'should not create user with too long password' do
    email = 'test@test.test'
    password = 'very-long-password'*10
    password_confirmation = 'very-long-password'*10
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
  end

  test 'should not create user with too long email' do
    email = 'test'*100 + '@test.test'
    password = 'password'
    password_confirmation = 'password'
    params = {
      user: {
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
  end

  test 'should not create user without password confirmation' do
    email = 'test@test.test'
    password = 'password'
    params = {
      user: {
        email: email,
        password: password
      }
    }

    post api_v1_users_path, params: params

    assert_response :unprocessable_entity
  end
end
