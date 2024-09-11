class ProductsController < ApplicationController
  include Auth
  before_action :admin_permission_required, except: [ :index, :search ]

  def index
    page = params[:page] || 1
    products = Product.order("created_at DESC").page(page).per(10)
    render "products/product", status: :ok, locals: { products: products }
  end

  def create
    product = Product.new(create_params)

    if product.save
      render "products/created", status: :ok, locals: { product: product }
    else
      render "common/errors", status: :bad_request, locals: { errors: product.errors }
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])

    if product.present?
      if product.destroy
        render json: { msg: "product removed" }, status: :ok
      else
         render "common/errors", status: :bad_request, locals: { errors: product.errors }
      end
    else
      render json: { msg: "product not found" }, status: :bad_request
    end
  end

  def search
    products = Product.search(params[:search])

    render json: { products: products }
  end

  private

  def create_params
    params.permit(:name, :price, :description, :category_id)
  end
end
