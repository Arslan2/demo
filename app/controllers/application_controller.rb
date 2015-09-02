class ApplicationController < ActionController::Base
  before_filter :set_cart_count
  protect_from_forgery

  def owner? (user_id)
    current_user.to_param.to_i == user_id if current_user
  end

  def display_name (user)
    [user.first_name, user.last_name].join(" ")
  end

  def in_cart? (product)
    (ActiveSupport::JSON.decode(cookies[:products])).include?(product.id.to_s) if cookies[:products]
  end

  def short_description(product)
    [product.body[0..50],"..."].join
  end

  def decode_cookie
    return ActiveSupport::JSON.decode(cookies[:products]) if cookies[:products]
    return []
  end

  def encode_cookie(product)
    { value: ActiveSupport::JSON.encode(product)}
  end

  def set_products
    return @products = Product.find(decode_cookie) if cookies[:products]
    flash[:alert] = "You don't have any order yet."
  end

  def calculate_total
    @sum = @products.sum(&:price) if @products
  end

  def after_sign_in_path_for(resource)
    return new_order_path if session[:checkout_path]
    return admin_dashboard_path if request.referer == new_user_session_path
    return user_dashboard_path
  end

  private
  def set_cart_count
    @cart_count = decode_cookie.length
  end

  helper_method :owner?, :display_name, :in_cart?, :short_description

end
