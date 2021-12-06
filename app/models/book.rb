class Book < ApplicationRecord
  belongs_to :user

  validates :author, :title, presence: true, length: { in: 3...255 }

  before_destroy :ensure_book_is_not_borrowed, prepend: true

  def borrowed?
    user.borrowings.where(book_id: id).exists?
  end

  private

  def ensure_book_is_not_borrowed
    if borrowed?
      errors.add(:book_id, "book with id=#{id} is borrowed")
      throw :abort
    end
  end
end
