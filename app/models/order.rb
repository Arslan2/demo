class Order < ActiveRecord::Base
  has_many :products, through: :order_products

  attr_accessible :amount, :discount
end
