class Product < ActiveRecord::Base

  PAGE_SIZE = 12
  paginates_per 5
  REVIEWS_PER_PAGE = 3

  attr_accessible :body, :price, :title, :attachments_attributes, :user_id, :delta

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many  :reviews, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products
  belongs_to :user

  validates :body, :price, :title, presence: true
  validates_numericality_of :price, greater_than_equal_to: 0

  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :ordered, -> { order("created_at desc") }

  define_index do
    indexes body
    indexes title
    set_property delta: true
  end

  def self.perform_search(options)
    options = {} if options.blank?
    search_params  = default_search_options(options)
    self.ordered.search options[:search], search_params
  end

  def self.default_search_options(options)
    {
      page: options[:page],
      per_page: PAGE_SIZE,
    }
  end
end
