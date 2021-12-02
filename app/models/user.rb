class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, length: { in: 3...255 },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { in: 6...128 }

  has_secure_password

  before_save :normalize_email

  private

  def normalize_email
    email.downcase!
  end
end
