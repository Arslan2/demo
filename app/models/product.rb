class Product < ActiveRecord::Base
  PER_PAGE_SIZE = 5
  attr_accessible :body, :price, :title

  scope :ordered, -> { order("created_at desc") }
end
