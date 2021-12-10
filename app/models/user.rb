class User < ApplicationRecord
  has_many :books
  has_many :readers
  has_many :borrowings

  validates :email, presence: true, length: { maximum: 255 },
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  normalize :email, with: :downcase

  has_secure_password
end
