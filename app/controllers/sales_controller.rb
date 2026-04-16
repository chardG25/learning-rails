class SalesController < ApplicationController
  def create
    @sale = Sale.new(sale_params)
    @sale.total_price = @sale.quantity * Product.find(@sale.product_id).price

    if @sale.save
      @sale.product.update(inventory_count: @sale.product.inventory_count - @sale.quantity)
      redirect_to purchase_path, notice: "Purchase successful"
    else
      @products = Product.all
      @product = @sale.product
      flash.now[:alert] = "Not enough stock (#{@sale.product.inventory_count} left)"
      render "products/confirmPurchase", status: :unprocessable_entity
    end
  end

  def index
    @sales = Sale.includes(:product).all
  end
  private

  def sale_params
    params.require(:sale).permit(:product_id, :quantity)
  end
end
