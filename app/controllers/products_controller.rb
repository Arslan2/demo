class ProductsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.ordered.page(params[:page]).per(Product::PAGE_SIZE)
    respond_with(@products)
  end

  def show
    @reviews = @product.reviews.limit(Product::REVIEWS_PER_PAGE)
    @review = Review.new
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = current_user.products.new(params[:product])
    @product.save
    respond_with(@product)
  end

  def update
    return redirect_to product_path, notice: "You can only modify your own Product." unless owner?(@product.user_id)
    @product.update_attributes(params[:product])
    respond_with(@product)
  end

  def destroy
    return redirect_to root_url, notice: "You can only delete your own Product." unless owner?(@product.user_id)
    @product.destroy
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.includes(:user).find(params[:id])
    end
end
