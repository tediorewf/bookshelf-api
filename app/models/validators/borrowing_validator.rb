module Validators
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
        borrowing.errors.add(:book, 'must not be borrowed')
      end
    end

    def book_belongs_to_user
      unless user.books.exists?(book_id)
        borrowing.errors.add(:book, 'must belong to user')
      end
    end

    def reader_belongs_to_user
      unless user.readers.exists?(reader_id)
        borrowing.errors.add(:reader, 'must belong to user')
      end
    end

    def user
      @user ||= User.find(user_id)
    end

    def user_id
      borrowing.user_id
    end

    def reader_id
      borrowing.reader_id
    end

    def book
      @book ||= Book.find(book_id)
    end

    def book_id
      borrowing.book_id
    end

    attr_reader :borrowing
  end
end
