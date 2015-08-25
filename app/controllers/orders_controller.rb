class OrdersController < InheritedResources::Base

  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    @order = Order.find(params[:id])
  end
end

