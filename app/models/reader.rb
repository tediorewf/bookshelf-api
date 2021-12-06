class Reader < ApplicationRecord
  include EmailNormalizer
  include FirstNameCapitalizer
  include LastNameCapitalizer

  belongs_to :user

  validates :first_name, :last_name, presence: true, length: { in: 3...255 }
  validates :phone, presence: true, numericality: true, length: { in: 10..15 }
  validates :email, presence: true, uniqueness: true, length: { in: 3...255 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save :capitalize_first_name, :capitalize_last_name, :normalize_email

  before_destroy :ensure_reader_is_not_a_borrower, prepend: true

  def borrower?
    user.borrowings.where(reader_id: id).exists?
  end

  private

  def ensure_reader_is_not_a_borrower
    if borrower?
      errors.add(:base, "reader with id=#{id} is borrower")
      throw :abort
    end
  end
end
