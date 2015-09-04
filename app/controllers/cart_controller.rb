class CartController < ApplicationController
  before_filter :set_products, only: [:show, :remove, :discount]
  before_filter :set_sum, only: [:show, :remove, :discount]
  before_filter :set_product_id, only: [:add, :remove]
  before_filter :check_coupon_applied, only: [:show, :discount]
  after_filter :discard_flash, only: [:discount]

  def show
    @coupon = DiscountCoupon.new
    set_discount
  end

  def add
    cookies[:products] = encode_cookie(decode_cookie.push(params[:product_id])) unless decode_cookie.include?(params[:product_id])
    @cart_count = @cart_count.to_i + 1
  end

  def remove
    cart = decode_cookie
    if decode_cookie.include?(params[:product_id])
      cookies[:products] = { value: ActiveSupport::JSON.encode(cart -= [params[:product_id]]) }
      @cart_count = @cart_count.to_i - 1
      set_products
      set_sum
      set_discount
    end
  end

  def discount
    if @coupon_applied
      flash[:alert] = "You have already applied a coupon"
    else
      @is_valid_coupon = check_coupon_number
      if @is_valid_coupon
        set_sum
        set_discount
        flash[:notice] = "Congratulations!! you have received a special discount"
      else
        flash[:alert] = "Your coupon number is either invalid or has been consumed"
      end
    end
  end

  private
    def set_products
      return @products = Product.find(decode_cookie) if cookies[:products]
      flash[:alert] = "You don't have any order yet."
    end

    def set_sum
      if @products
        @sum = @products.sum(&:price)
      end
    end

    def set_product_id
      @id = params[:product_id]
    end

    def check_coupon_number
      unless DiscountCoupon.active_coupon(params[:discount_coupon][:coupon_number]).first
        return false
      end
      session[:coupon_number] = params[:discount_coupon][:coupon_number]
      return true
    end

    def check_coupon_applied
      @coupon_applied = true if session[:coupon_number].present?
    end

    def discard_flash
      flash.discard
    end
end
