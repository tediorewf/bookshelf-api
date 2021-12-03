class Reader < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, presence: true, length: { in: 3...255 }
  validates :phone, presence: true, numericality: true, length: { in: 10..15 }
  validates :email, presence: true, uniqueness: true, length: { in: 3...255 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save :capitalize_first_name, :capitalize_last_name, :normalize_email

  private

  def capitalize_first_name
    first_name.capitalize!
  end

  def capitalize_last_name
    last_name.capitalize!
  end

  def normalize_email
    email.downcase!
  end
end
