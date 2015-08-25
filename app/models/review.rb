class Review < ActiveRecord::Base
  attr_accessible :comment
  belongs_to :product
  belongs_to :user

  validates :comment, presence: true, length: { minimum: 2, maximum: 150 }

  scope :ordered, -> { order('updated_at desc') }
end
