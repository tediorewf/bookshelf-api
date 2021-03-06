class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :reader

  validate do |borrowing|
    Validators::BorrowingValidator.new(borrowing).validate
  end
end
