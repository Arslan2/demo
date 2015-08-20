class UserController < ApplicationController
  before_filter :authenticate_user!
  def show
  end

  def dashboard
    @products = current_user.products.includes(:attachments).ordered.page(params[:page]).per(User::PER_PAGE)
    @reviews = current_user.reviews.includes(:product).ordered.page(params[:page]).per(User::PER_PAGE)
  end
end
