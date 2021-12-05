class Book < ApplicationRecord
  belongs_to :user

  validates :author, :title, presence: true, length: { in: 3...255 }
  validate :book_is_not_borrowed, on: :destroy

  def borrowed?
    user.borrowings.where(book_id: id).exists?
  end

  private

  def book_is_not_borrowed
    errors.add(:book_id, "book with id=#{id} is borrowed") if borrowed?
  end
end
