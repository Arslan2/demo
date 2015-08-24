ActiveAdmin.register Review do
  belongs_to :product, parent_class: Product

  index do
    column :user_id
    column :comment
    column :created_at
    column :user_id
    column :product_id

    default_actions
  end
end
