class CartsController < ApplicationController
  def index
    session[:cart] ||= {}
    @cart = session[:cart]
    @products = Product.where(id: @cart.keys)
  end

  def add
    session[:cart] ||= {}

    return redirect_to cart_path, alert: "No products selected" if params[:products].blank?

    params[:products].each do |product_id, data|
      quantity = data[:quantity].to_i
      next if quantity <= 0

      session[:cart][product_id.to_s] ||= 0
      session[:cart][product_id.to_s] += quantity
    end

    redirect_to cart_path, notice: "Items added to cart"
  end

  def remove
    session[:cart] ||= {}

    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)

    redirect_to cart_path, notice: "Item removed"
  end

  def clear
    session[:cart] = {}
    redirect_to cart_path, notice: "Cart cleared"
  end

  def update
    session[:cart] ||= {}

    params[:cart]&.each do |product_id, quantity|
      product_id = product_id.to_s
      quantity = quantity.to_i

      if quantity <= 0
        session[:cart].delete(product_id)
      else
        session[:cart][product_id] = quantity
      end
    end

    redirect_to cart_path, notice: "Cart updated"
  end

  def receipt
    @sale = Sale.find(params[:id])
  end
end
