class ReviewsController < ApplicationController
  before_filter :set_product
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :authenticate_review_owner, only: [:edit, :destroy]
  respond_to :html, :js

  def index
    @reviews = @product.reviews
    respond_with(@reviews)
  end

  def show
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    unless owner?(@product.user_id)
      @review = @product.reviews.new(params[:review])
      @review.user_id = current_user.id
      @review.save
      respond_to do |format|
        format.html { redirect_to @product }
        format.js
      end
    end
  end

  def update
    @review.update_attributes(params[:review])
    redirect_to([@product, @review])
  end

  def destroy
    @review.destroy
    redirect_to product_path(@product)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def authenticate_review_owner
      unless owner?(@review.user_id) || owner?(@product.user_id)
         flash[:notice] = "You can only modify your own reviews."
         redirect_to action: "index"
      end
    end
end
