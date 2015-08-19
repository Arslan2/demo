class User < ActiveRecord::Base

  has_one :attachment, as: :attachable
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :attachment_attributes

  accepts_nested_attributes_for :attachment

  def fetch_attachment
    self.attachment.present? ? self.attachment : self.build_attachment
  end

end
