class Order < ActiveRecord::Base
  attr_accessible :amount, :discount
end
