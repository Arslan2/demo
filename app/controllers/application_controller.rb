class ApplicationController < ActionController::Base
  protect_from_forgery

  def owner? (user_id)
    current_user.id == user_id
  end

  helper_method :owner?

end
