class UserController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  def show
    @user = User.find(params[:id])
    @products = @user.products.ordered.page(params[:product_page])
  end

  def dashboard
    @products = current_user.products.includes(:attachments).ordered.page(params[:product_page])
    @reviews = current_user.reviews.includes(:product).ordered.page(params[:review_page])
  end
end
