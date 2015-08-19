class ReviewsController < ApplicationController
  before_filter :set_product
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @reviews = Product.find(params[:product_id]).reviews
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
    @review = @product.reviews.build(params[:review])
    @review.save
    respond_to do |format|
      format.html { redirect_to @product }
      format.js
    end
  end

  def update
    @review.update_attributes(params[:review])
    redirect_to([@product, @review])
  end

  def destroy
    @review.destroy
    redirect_to([@product, @review])
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end
end
