class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :reader

  validates_uniqueness_of :book_id, scope: %i(user reader)
end
