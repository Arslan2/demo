class CreateDiscountCoupons < ActiveRecord::Migration
  def change
    create_table :discount_coupons do |t|
      t.string :coupon_number, null: :false
      t.boolean :is_active

      t.timestamps
    end
  end
end
