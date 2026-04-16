class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product, only: [ :edit, :update, :show, :destroy ]

  def index
    @products = Product.all
  end

  def show
    # @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @product = Product.find(params[:id])
  end

  def update
    # @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end


  def purchase
    @products = Product.all
  end

  def confirmPurchase
    @product = Product.find(params[:id])
  end

  def confirm
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.expect(product: [ :name, :inventory_count, :price ])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
