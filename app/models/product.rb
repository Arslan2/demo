class Product < ActiveRecord::Base

  PER_PAGE_SIZE = 5
  attr_accessible :body, :price, :title, :attachments_attributes

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many  :reviews, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :ordered, -> { order("created_at desc") }

end
