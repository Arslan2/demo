class Order < ActiveRecord::Base
  has_many :products, through: :order_products
  has_many :order_products, dependent: :destroy
  belongs_to :user

  attr_accessible :amount, :discount, :shipping_address
end
