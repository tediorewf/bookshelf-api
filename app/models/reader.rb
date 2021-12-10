class Reader < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 60 }
  validates :phone, presence: true, numericality: true, length: { in: 10..15 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  before_destroy :ensure_reader_is_not_a_borrower

  normalize :email, with: :downcase
  normalize :name, with: :capitalize

  def borrower?
    user.borrowings.where(reader_id: id).exists?
  end

  private

  def ensure_reader_is_not_a_borrower
    if borrower?
      errors.add(:user, 'must not be a borrower')
      throw :abort
    end
  end
end
