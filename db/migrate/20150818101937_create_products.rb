class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, limit: 50
      t.text :body
      t.float :price

      t.timestamps
    end
  end
end
