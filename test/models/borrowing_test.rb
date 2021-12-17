require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  setup do
    @user = users(:two)
    @reader = readers(:two)
    @book = books(:two)

    @borrowing  = Borrowing.new(user: @user,
                                reader: @reader,
                                book: @book)
  end

  test 'borrowing should be valid' do
    assert @borrowing.valid?
  end
end
