ActiveAdmin.register Attachment do
  belongs_to :product, parent_class: Product
end
