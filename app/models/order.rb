class Order < ActiveRecord::Base
  has_many :products, through: :order_products
  has_many :order_products, dependent: :destroy
  belongs_to :user

  attr_accessible :amount, :discount, :shipping_address, :stripe_card_token
  attr_accessor :stripe_card_token

  validates :amount, :shipping_address, :stripe_card_token, presence: true
  validates_numericality_of :amount, greater_than_equal_to: 0

  def process_payment(amount)
    if valid?
      begin
        charge = Stripe::Charge.create(
          amount: (amount.to_f*100).to_i,
          currency: "usd",
          source: stripe_card_token,
          description: "Products purchases at shopify"
        )

        rescue Stripe::CardError => e
        render :new, notice: "Your card has been declined."
      end
    end
  end

  def save_order_products(products)
    products.each do |product|
      order_product = self.order_products.new
      order_product.product_id = product.id
      order_product.save
    end
  end
end
