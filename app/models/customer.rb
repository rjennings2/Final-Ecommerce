class Customer < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password
end