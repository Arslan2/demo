class Review < ActiveRecord::Base
  paginates_per 5

  attr_accessible :comment
  belongs_to :product
  belongs_to :user

  validates :comment, presence: true, length: { minimum: 2, maximum: 500 }

  scope :ordered, -> { order('updated_at desc') }
end
