class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_products, only: [ :show, :edit, :update, :destroy ]
  # allow_unauthenticated_access only: %i[ index show ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product =  Product.new
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
  end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.expect(product: [ :name ])
  end

  def set_products
    @product = Product.find(params[:id])
  end
end
