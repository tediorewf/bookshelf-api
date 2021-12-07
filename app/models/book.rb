class Book < ApplicationRecord
  belongs_to :user

  validates :author, :title, presence: true, length: { maximum: 100 }

  before_destroy :ensure_book_is_not_borrowed, prepend: true

  def borrowed?
    user.borrowings.where(book_id: id).exists?
  end

  private

  def ensure_book_is_not_borrowed
    if borrowed?
      errors.add(:id, "book with id=#{id} is borrowed")
      throw :abort
    end
  end
end
