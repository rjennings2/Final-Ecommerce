class Product < ApplicationRecord
  belongs_to :category

  validates :product_name, :price, :size, :colour, :description, presence: true
end
