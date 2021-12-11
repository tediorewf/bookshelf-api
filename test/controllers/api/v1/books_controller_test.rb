require 'test_helper'

class Api::V1::BooksControllerTest < ActionDispatch::IntegrationTest
  TOKEN_TYPE = 'Bearer'.freeze
  private_constant :TOKEN_TYPE

  test 'unauthorized user unable to get books' do
    get api_v1_books_path

    assert_response :unauthorized
  end

  test 'unauthorized user unable to create a book' do
    post api_v1_books_path

    assert_response :unauthorized
  end

  test 'unauthorized user unable to get a book' do
    get api_v1_book_path(1)

    assert_response :unauthorized
  end

  test 'unauthorized user unable to delete a book' do
    delete api_v1_book_path(1)

    assert_response :unauthorized
  end

  test 'unauthorized user unable to update a book' do
    put api_v1_book_path(1)

    assert_response :unauthorized
  end

  test 'authorized user able to get books' do
    email = 'johndoe@gmail.com'
    password = 'password'
    password_confirmation = 'password'
    user = User.create(email: email,
                       password: password,
                       password_confirmation: password_confirmation)
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_books_path, headers: headers

    assert_response :ok
  end

  test 'authorized user able to create a book' do
    email = 'example-email-444@gmail.com'
    password = 'password'
    password_confirmation = 'password'
    user = User.create(email: email,
                       password: password,
                       password_confirmation: password_confirmation)
    author = 'Author'
    title = 'Title'
    params = {
      book: {
        author: author,
        title: title
      }
    }
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    post api_v1_books_path, params: params, headers: headers

    assert_response :created
  end

  test 'authorized user able to get his book' do
    email = 'email-738142@example.com'
    password = 'password'
    password_confirmation = 'password'
    user = User.create(email: email,
                       password: password,
                       password_confirmation: password_confirmation)
    book = user.books.create(author: 'Author', title: 'Title')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_book_path(book), headers: headers

    assert_response :ok
  end

  test 'authorized user able to delete his book which is not borrowed' do
    email = 'test-email-44123@example.com'
    password = 'password'
    password_confirmation = 'password'
    user = User.create(email: email,
                       password: password,
                       password_confirmation: password_confirmation)
    book = user.books.create(author: 'Test Author', title: 'Test Title')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_book_path(book), headers: headers

    assert_response :no_content
  end

  test 'authorized user able to update his book' do
    email = 'test-email-1337@outlook.com'
    password = 'password'
    password_confirmation = 'password'
    user = User.create(email: email,
                       password: password,
                       password_confirmation: password_confirmation)
    book = user.books.create(author: 'Author 123', title: 'Title 123')
    author = 'Author'
    title = 'Title'
    params = {
      book: {
        author: author,
        title: title
      }
    }
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    put api_v1_book_path(book), params: params, headers: headers

    assert_response :created
  end

  test 'authorized user unable to delete a book which he does not own' do
    user_owner = User.create(email: 'user-owner-1@yahoon.com',
                             password: 'password',
                             password_confirmation: 'password')
    book = user_owner.books.create(author: 'Book author 1337',
                                   title: 'Book title 1337')
    arbitrary_user = User.create(email: 'arbitrary-user-1@gmail.com',
                                 password: 'password',
                                 password_confirmation: 'password')
    token = TokenService.encode(sub: arbitrary_user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_book_path(book), headers: headers

    assert_response :not_found
  end

  test 'authorized user unable to update a book which he does not own' do
    user_owner = User.create(email: 'user-owner-2@example.com',
                             password: 'password',
                             password_confirmation: 'password')
    book = user_owner.books.create(author: 'Book Author Example',
                                   title: 'Book Title Example')
    arbitrary_user = User.create(email: 'arbitrary-user-2@example.com',
                                 password: 'password',
                                 password_confirmation: 'password')
    author = 'Author'
    title = 'Title'
    params = {
      book: {
        author: author,
        title: title
      }
    }
    token = TokenService.encode(sub: arbitrary_user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    put api_v1_book_path(book), params: params, headers: headers

    assert_response :not_found
  end
end
