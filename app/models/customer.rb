class Customer < ApplicationRecord
  belongs_to :province
  has_one :cart, dependent: :destroy

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password
  validates :city, :street, :house_number, :province, presence: true
  validates :province_id, presence: true
  validates :house_number, numericality: { only_integer: true }
  validates :street, format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters and spaces" }
  validates :city, format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters and spaces" }
end