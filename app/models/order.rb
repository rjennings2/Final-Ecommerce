class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  validates :shipping_address, presence: true
  validates :total_price, presence: true
end