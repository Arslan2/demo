class Attachment < ActiveRecord::Base

  attr_accessible :attachable_id, :attachable_type, :photo

  belongs_to :attachable, polymorphic: true, dependent: :destroy

  has_attached_file :photo, styles: { small: "150x150>", medium: "500x500>" },
                            url: "/assets/products/:id/:style/:basename.:extension",
                            path: ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, less_than: 5.megabytes
  validates_attachment_content_type :photo, content_type: ['image/jpeg', 'image/png']

end
