class AddFirstNameAndLastNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, limit: 30
    add_column :users, :last_name, :string, limit: 30
  end
end
