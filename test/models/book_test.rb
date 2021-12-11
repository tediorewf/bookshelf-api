require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    book_attributes = {
      author: 'Author',
      title: 'Title'
    }
    @book = @user.books.new(book_attributes)
  end

  test 'should be valid' do
    assert @book.valid?
  end

  test 'not borrowed' do
    assert_not @book.borrowed?
  end

  test 'author name should not be nil' do
    @book.author = nil

    assert_not @book.valid?
  end

  test 'title should not be nil' do
    @book.title = nil

    assert_not @book.valid?
  end

  test 'author should not be blank' do
    @book.author = ' '

    assert_not @book.valid?
  end

  test 'title should not be blank' do
    @book.title = ' '

    assert_not @book.valid?
  end

  test 'author name should not be too long' do
    @book.author = 'author'*100

    assert_not @book.valid?
  end

  test 'title should not be too long' do
    @book.title = 'title'*100

    assert_not @book.valid?
  end
end
