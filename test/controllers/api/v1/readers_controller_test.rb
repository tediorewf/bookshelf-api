require 'test_helper'

class Api::V1::ReadersControllerTest < ActionDispatch::IntegrationTest
  TOKEN_TYPE = 'Bearer'.freeze
  private_constant :TOKEN_TYPE

  test 'unauthorized user unable to get readers' do
    get api_v1_readers_path

    assert_response :unauthorized
  end

  test 'unauthorized user unable to create a reader' do
    post api_v1_readers_path

    assert_response :unauthorized
  end

  test 'unauthorized user unable to get a reader' do
    get api_v1_reader_path(1)

    assert_response :unauthorized
  end

  test 'unauthorized user unable to delete a reader' do
    delete api_v1_reader_path(1)

    assert_response :unauthorized
  end

  test 'unauthorized user unable to update a reader' do
    put api_v1_reader_path(1)

    assert_response :unauthorized
  end

  test 'authorized user able to get readers' do
    user = User.create(email: 'test-user-email@test.com',
                       password: 'password',
                       password_confirmation: 'password')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_readers_path, headers: headers

    assert_response :ok
  end

  test 'authorized user able to create a reader' do
    email = 'reader@reder.reader'
    name = 'Name'
    phone = '88888888888'
    params = {
      reader: {
        email: email,
        name: name,
        phone: phone
      }
    }
    user = User.create(email: 'test@test.test',
                       password: 'password',
                       password_confirmation: 'password')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    post api_v1_readers_path, params: params, headers: headers
    assert_response :created
  end

  test 'authorized user able to get his reader' do
    user = User.create(email: 'test1234567890@test.test',
                       password: 'password',
                       password_confirmation: 'password')
    reader = user.readers.create(name: 'test',
                                 email: 'reader1234567890@reader.reader',
                                 phone: '99999999999')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_reader_path(reader), headers: headers

    assert_response :ok
  end

  test 'authorized user able to delete his reader which is not a borrower' do
    user = User.create(email: "test-user-333311@gmail.com",
                       password: 'password',
                       password_confirmation: 'password')
    reader = user.readers.create(name: 'test',
                                 email: 'test-reader-333311@example.com',
                                 phone: '7777777777')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_reader_path(reader), headers: headers

    assert_response :no_content
  end

  test 'authorized user able to update his reader' do
    email = 'reader-reader-111@example.com'
    name = 'Name'
    phone = '88888888888'
    params = {
      reader: {
        email: email,
        name: name,
        phone: phone
      }
    }
    user = User.create(email: 'example-user@test.co.uk',
                       password: 'password',
                       password_confirmation: 'password')
    reader = user.readers.create(name: 'Test reader 1337',
                                 email: 'test-reader-1337@example.com',
                                 phone: '133713371337')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    put api_v1_reader_path(reader), params: params, headers: headers

    assert_response :created
  end

  test 'authorized user unable to delete a reader which he does not own' do
    user_owner = User.create(email: 'user-owner@example.com',
                             password: 'password',
                             password_confirmation: 'password')
    reader = user_owner.readers.create(name: 'Reader',
                                 email: 'reader-777@example.com',
                                 phone: '77777777777')
    arbitrary_user = User.create(email: 'arbitrary-user@example.com',
                                 password: 'password',
                                 password_confirmation: 'password')
    token = TokenService.encode(sub: arbitrary_user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_reader_path(reader), headers: headers

    assert_response :not_found
  end

  test 'authorized user unable to update a reader which he does not own' do
    email = 'reader@reder.reader'
    first_name = 'First'
    last_name = 'Last'
    phone = '88888888888'
    params = {
      reader: {
        email: email,
        first_name: first_name,
        last_name: last_name,
        phone: phone
      }
    }
    user_owner = User.create(email: 'user-owner-5@example.com',
                             password: 'password',
                             password_confirmation: 'password')
    reader = user_owner.readers.create(name: 'Reader 5',
                                       email: 'reader-777@example.com',
                                       phone: '66666666666')
    arbitrary_user = User.create(email: 'arbitrary-user-1@example.com',
                                 password: 'password',
                                 password_confirmation: 'password')
    token = TokenService.encode(sub: arbitrary_user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    put api_v1_reader_path(reader), params: params, headers: headers

    assert_response :not_found
  end
end
