require "test_helper"

class Api::V1::BooksControllerTest < ActionDispatch::IntegrationTest
  TOKEN_TYPE = 'Bearer'.freeze
  private_constant :TOKEN_TYPE

  setup do
    @user_one = users(:one)
    @user_two = users(:two)

    @book_one = books(:one)
    @book_two = books(:two)
  end

  test "unauthorized user unable to get books" do
    get api_v1_books_path

    assert_response :unauthorized
  end

  test "unauthorized user unable to create a book" do
    post api_v1_books_path

    assert_response :unauthorized
  end

  test "unauthorized user unable to get a book" do
    get api_v1_book_path(@book_one)

    assert_response :unauthorized
  end

  test "unauthorized user unable to delete a book" do
    delete api_v1_book_path(@book_one)

    assert_response :unauthorized
  end

  test "unauthorized user unable to update a book" do
    put api_v1_book_path(@book_one)

    assert_response :unauthorized
  end

  test "authorized user able to get books" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_books_path, headers: headers

    assert_response :ok
  end

  test "authorized user able to create a book" do
    author = "Author"
    title = "Title"
    params = {
      book: {
        author: author,
        title: title
      }
    }
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    assert_difference("Book.count", 1) do
      post api_v1_books_path,
           params: params,
           headers: headers
    end
    assert_response :created
  end

  test "authorized user able to get his book" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_book_path(@book_one), headers: headers

    assert_response :ok
  end

  test "authorized user able to delete his book" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    assert_difference("Book.count", -1) do
      delete api_v1_book_path(@book_one),
             headers: headers
    end
    assert_response :no_content
  end

  test "authorized user able to update his book" do
    author = "Author"
    title = "Title"
    params = {
      book: {
        author: author,
        title: title
      }
    }
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    assert_difference("Book.count", 0) do
      put api_v1_book_path(@book_one), params: params, headers: headers
    end
    assert_response :created
  end

  test "authorized user unable to delete a book which he does not own" do
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_book_path(@book_two), headers: headers

    assert_response :not_found
  end

  test "authorized user unable to update a book which he does not own" do
    author = "Author"
    title = "Title"
    params = {
      book: {
        author: author,
        title: title
      }
    }
    token = TokenService.encode(sub: @user_one.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    put api_v1_book_path(@book_two), params: params, headers: headers

    assert_response :not_found
  end
end
