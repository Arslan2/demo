class DiscountCoupon < ActiveRecord::Base
  DISCOUNT_PERCENT = 10
  attr_accessible :coupon_number, :is_active
  scope :active_coupon, -> (coupon){ where(is_active: true, coupon_number: coupon) }

  def self.get_discount(amount)
    amount - (amount / 100) * DISCOUNT_PERCENT
  end
end
