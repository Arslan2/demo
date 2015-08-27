class CartController < ApplicationController
  before_filter :set_products, only: [:show, :remove]
  before_filter :set_sum, only: [:show, :remove]
  before_filter :set_product_id, only: [:add, :remove]

  def show
  end

  def add
    if cookies[:products]
      cookies[:products] = encode_cookie(decode_cookie.push(params[:product_id])) unless decode_cookie.include?(params[:product_id])
    else
      cookies[:products] = encode_cookie([params[:product_id]])
    end
  end

  def remove
    cart = decode_cookie
    cookies[:products] = { value: ActiveSupport::JSON.encode(cart -= [params[:product_id]])} if decode_cookie.include?(params[:product_id])
    set_products
    set_sum
  end

  private
    def set_products
      return @products = Product.find(decode_cookie) if cookies[:products]
      flash[:alert] = "You don't have any order yet."
    end

    def set_sum
      @sum = @products.sum(&:price) if @products
    end

    def set_product_id
      @id = params[:product_id]
    end
end
