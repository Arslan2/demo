class UserController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = User.find(params[:id])
    @products = @user.products.ordered.page(params[:page]).per(User::PER_PAGE)
  end

  def dashboard
    @products = current_user.products.includes(:attachments).ordered.page(params[:page]).per(User::PER_PAGE)
    @reviews = current_user.reviews.includes(:product).ordered.page(params[:page]).per(User::PER_PAGE)
  end
end
