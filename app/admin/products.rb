ActiveAdmin.register Product do
  scope :ordered

  index do
    column :title
    column :body
    column "Created At", :created_at
    column :price, :sortable => :price do |product|
      div :class => "price" do
        number_to_currency product.price
      end
    end

    column :reviews do |review|
      link_to "reviews", admin_product_reviews_path(review)
    end

    column :attachments do |attachment|
      link_to "attachments", admin_product_attachments_path(attachment)
    end

    default_actions
  end

end
