class Book < ApplicationRecord
  belongs_to :user

  validates :author, :title, presence: true, length: { maximum: 100 }

  before_destroy :ensure_book_is_not_borrowed

  def borrowed?
    user.borrowings.where(book_id: id).exists?
  end

  private

  def ensure_book_is_not_borrowed
    if borrowed?
      errors.add(:book, 'must not be borrowed')
      throw :abort
    end
  end
end
