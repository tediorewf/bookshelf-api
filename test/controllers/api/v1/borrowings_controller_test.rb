require 'test_helper'

class Api::V1::BorrowingsControllerTest < ActionDispatch::IntegrationTest
  TOKEN_TYPE = 'Bearer'.freeze
  private_constant :TOKEN_TYPE

  test 'unauthorized user unable to get borrowings' do
    get api_v1_borrowings_path

    assert_response :unauthorized
  end

  test 'unauthorized user unable to create a borrowing' do
    post api_v1_borrowings_path

    assert_response :unauthorized
  end

  test 'unauthorized user unable to get a borrowing' do
    get api_v1_borrowing_path(1)

    assert_response :unauthorized
  end

  test 'unauthorized user unable to delete a borrowing' do
    delete api_v1_borrowing_path(1)

    assert_response :unauthorized
  end

  test 'authorized user able to get borrowings' do
    user = User.create(email: 'email@example.com',
                       password: 'password',
                       password_confirmation: 'password')
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    get api_v1_borrowings_path, headers: headers

    assert_response :ok
  end

  test 'authorized user able to create a borrowing' do
    user = User.create(email: 'email@example.com',
                       password: 'password',
                       password_confirmation: 'password')
    book = user.books.create(author: 'Author',
                             title: 'title')
    reader = user.readers.create(email: 'reader89123@example.com',
                                 name: 'Reader',
                                 phone: '44444444444')
    params = {
      borrowing: {
        reader_id: reader.id,
        book_id: book.id
      }
    }
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    post api_v1_borrowings_path, params: params, headers: headers

    assert_response :created
  end

  test 'authorized user able to delete a borrowing' do
    user = User.create(email: 'email@example.com',
                       password: 'password',
                       password_confirmation: 'password')
    book = user.books.create(author: 'Author', title: 'title')
    reader = user.readers.create(email: 'reader89123@example.com',
                                 name: 'Reader',
                                 phone: '44444444444')
    borrowing = user.borrowings.create(book: book, reader: reader)
    token = TokenService.encode(sub: user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_borrowing_path(borrowing), headers: headers

    assert_response :no_content
  end

  test 'authorized user unable to delete a borrowing which he does not own' do
    usual_user = User.create(email: 'usual-user3314124@example.com',
                             password: 'password',
                             password_confirmation: 'password')
    owner_user = User.create(email: 'email@example.com',
                             password: 'password',
                             password_confirmation: 'password')
    owners_book = owner_user.books.create(author: 'Author222',
                                          title: 'Title333')
    owners_reader = owner_user.readers.create(email: 'best-reader-312@yahoo.com',
                                              name: 'The Best Reader',
                                              phone: '333333333333')
    owners_borrowing = owner_user.borrowings.create(book: owners_book,
                                                    reader: owners_reader)
    token = TokenService.encode(sub: usual_user.id)
    headers = {
      'Authorization' => token_with_type(TOKEN_TYPE, token)
    }

    delete api_v1_borrowing_path(owners_borrowing), headers: headers

    assert_response :not_found
  end
end
