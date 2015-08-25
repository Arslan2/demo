class ApplicationController < ActionController::Base
  protect_from_forgery

  def owner? (user_id)
    current_user.to_param.to_i == user_id if current_user
  end

  def display_name (user)
    [user.first_name, user.last_name].join(" ")
  end

  helper_method :owner?, :display_name

end
