class User < ActiveRecord::Base

  has_one :attachment, as: :attachable
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :attachment_attributes, :address

  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 50 }

  accepts_nested_attributes_for :attachment

  scope :ordered, -> { order('updated_at desc') }
  def fetch_attachment
    self.attachment || self.build_attachment
  end

end
