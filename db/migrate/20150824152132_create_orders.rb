class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :amount, null: :false
      t.float :discount, null: :false

      t.timestamps
    end
  end
end
