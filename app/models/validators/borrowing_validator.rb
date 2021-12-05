class BorrowingValidator
  def initialize(borrowing)
    @borrowing = borrowing
  end

  def validate
    book_is_not_borrowed
    book_belongs_to_user
    reader_belongs_to_user
  end

  private

  def book_is_not_borrowed
    if book.borrowed?
      borrowing.errors.add(
        :book_id,
        "book with book_id=#{book_id} is borrowed"
      )
    end
  end

  def book_belongs_to_user
    unless user.books.exists?(book_id)
      borrowing.errors.add(
        :book_id,
        "book with book_id=#{book_id} doesn't belong to user with user_id=#{user_id}"
      )
    end
  end

  def reader_belongs_to_user
    unless user.readers.exists?(reader_id)
      borrowing.errors.add(
        :reader_id,
        "reader with reader_id=#{reader_id} doesn't belong to user with user_id=#{user_id}"
      )
    end
  end

  def user
    borrowing.user
  end

  def reader_id
    borrowing.reader_id
  end

  def book
    borrowing.book
  end

  def book_id
    borrowing.book_id
  end

  def user_id
    borrowing.user_id
  end

  attr_reader :borrowing
end
