class ApplicationController < ActionController::Base
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
    ActiveSupport::JSON.decode(cookies[:products])
  end

  def encode_cookie(product)
    { value: ActiveSupport::JSON.encode(product)}
  end

  helper_method :owner?, :display_name, :in_cart?, :short_description

end
