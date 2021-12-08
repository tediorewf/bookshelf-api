require "test_helper"

class Api::V1::ReadersControllerTest < ActionDispatch::IntegrationTest
  TOKEN_TYPE = 'Bearer'.freeze
  private_constant :TOKEN_TYPE

  setup do
    @user_one = users(:one)
    @user_two = users(:two)

    @reader_one = readers(:one)
    @reader_two = readers(:two)
  end

  test "unauthorized user unable to get readers" do
    get api_v1_readers_path

    assert_response :unauthorized
  end

  test "unauthorized user unable to create a reader" do
    post api_v1_readers_path

    assert_response :unauthorized
  end

  test "unauthorized user unable to get a reader" do
    get api_v1_reader_path(@reader_one)

    assert_response :unauthorized
  end

  test "unauthorized user unable to delete a reader" do
    delete api_v1_reader_path(@reader_one)

    assert_response :unauthorized
  end

  test "unauthorized user unable to update a reader" do
    put api_v1_reader_path(@reader_one)

    assert_response :unauthorized
  end

  test "authorized user able to get readers" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_readers_path, headers: headers

    assert_response :ok
  end

  test "authorized user able to create a reader" do
    email = "reader@reder.reader"
    first_name = "First"
    last_name = "Last"
    phone = "88888888888"
    params = {
      reader: {
        email: email,
        first_name: first_name,
        last_name: last_name,
        phone: phone
      }
    }
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    assert_difference("Reader.count", 1) do
      post api_v1_readers_path,
           params: params,
           headers: headers
    end
    assert_response :created
  end

  test "authorized user able to get his reader" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_reader_path(@reader_one), headers: headers

    assert_response :ok
  end

  test "authorized user able to delete his reader" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    assert_difference("Reader.count", -1) do
      delete api_v1_reader_path(@reader_one),
             headers: headers
    end
    assert_response :no_content
  end

  test "authorized user able to update his reader" do
    email = "reader@reder.reader"
    first_name = "First"
    last_name = "Last"
    phone = "88888888888"
    params = {
      reader: {
        email: email,
        first_name: first_name,
        last_name: last_name,
        phone: phone
      }
    }
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    assert_difference("Reader.count", 0) do
      put api_v1_reader_path(@reader_one),
          params: params, headers: headers
    end
    assert_response :created
  end

  test "authorized user unable to delete a reader which he does not own" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_reader_path(@reader_two), headers: headers

    assert_response :not_found
  end

  test "authorized user unable to update a reader which he does not own" do
    email = "reader@reder.reader"
    first_name = "First"
    last_name = "Last"
    phone = "88888888888"
    params = {
      reader: {
        email: email,
        first_name: first_name,
        last_name: last_name,
        phone: phone
      }
    }
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    put api_v1_reader_path(@reader_two), params: params, headers: headers

    assert_response :not_found
  end
end
