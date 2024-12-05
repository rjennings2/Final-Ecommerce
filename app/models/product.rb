class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :product_name, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :size, presence: true, inclusion: { in: %w(S M L), message: "%{value} is not a valid size" }
  validates :colour, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters and spaces" }
  validates :description, presence: true, length: { maximum: 1000 }
end
