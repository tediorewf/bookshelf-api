class Book < ApplicationRecord
  belongs_to :user

  validates :author, :title, presence: true, length: { in: 3...255 }
end
