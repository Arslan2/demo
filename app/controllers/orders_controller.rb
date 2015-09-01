class OrdersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :set_products, only: [:new, :create]
  before_filter :calculate_total, only: [:new, :create]
  before_filter :set_discount, only: [:new, :create]

  def index
    @orders = current_user.orders
    respond_with(@orders)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    return flash[:alert] = "You dont have any product in your cart" if @products.blank?
    @order = Order.new
    @order.shipping_address = current_user.address
  end

  def create
    @order = current_user.orders.new(params[:order])
    @order.amount = @sum
    @order.discount = @discounted_sum
    @order.process_payment(get_price)
    if @order.save
      update_user_address(@order.shipping_address)
      @order.save_order_products(@products)
      clear_cart
      flash[:notice] = "Order completed"
    else
      flash[:alert] = "ERROR!! Order could not completed due to some reason"
    end
    respond_with(@order)
  end

  private
  def get_price
    @discounted_sum || @sum
  end

  def set_discount
    @discounted_sum = DiscountCoupon.get_discount(@sum) if session[:coupon_number]
  end

  def update_user_address(new_address)
    current_user.address = new_address
    current_user.save
  end

  def clear_cart
    cookies.delete :products
    session.delete(:coupon_number)
  end
end

