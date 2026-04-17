class SalesController < ApplicationController
  def index
    @sales = Sale.includes(:sale_items).order(created_at: :desc)
  end

  def show
    @sale = Sale.find(params[:id])
  end


  def create
  # return redirect_to cart_path, alert: "Cart is empty" if session[:cart].to_h.empty?

  sale = nil

  ActiveRecord::Base.transaction do
    sale = Sale.create!
    total = 0

    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      quantity = quantity.to_i

      if product.inventory_count < quantity
        raise "#{product.name} only has #{product.inventory_count} left"
      end

      subtotal = product.price * quantity
      total += subtotal

      sale.sale_items.create!(
        product: product,
        quantity: quantity,
        price: product.price
      )

      product.update!(
        inventory_count: product.inventory_count - quantity
      )
    end

    sale.update!(total_price: total)
    session[:cart] = {}
  end

  redirect_to cart_receipt_path(sale), notice: "Purchase successful!"
  rescue => e
    redirect_to cart_path, alert: e.message
  end
end
