class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type
  belongs_to :user, as: :attachable, dependent: :destroy
end
