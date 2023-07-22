class ProductController < ApplicationController
  before_action :login_required, except: [:index]

  # FIXME
  before_action -> { limit_access(action_name, :seller) }, only: [:create, :update, :delete]

  ##
  # The index function retrieves the last 50 products and renders them as JSON.
  def index
    @products = Product.last(50)

    render template: 'api/product/index', status: :ok
  end

  ##
  # The above function creates a new product and returns a JSON response indicating whether the product was successfully
  # created or not.
  def create
    @product = Product.new(create_params)

    if @product.save
      render json: { msg: "Product created" }, status: :created
    else
      render json: { msg: "Unable to create product", detail: { errors: @product.errors.full_messages } }, status: :bad_request
    end
  end

  ##
  # The `update` function updates a product record in the database and returns a JSON response indicating the success or
  # failure of the update operation.
  def update
    @product = Product.find_by(id: params[:id])

    if @product
      if @product.update(update_params)
        render json: { msg: "Product updated" }, status: :ok
      else
        render json: { msg: "Unable to update product", detail: { errors: @product.errors.full_messages } }, status: :bad_request
      end
    else
      render json: { msg: "Product not found" }, status: :bad_request
    end
  end

  ##
  # The `delete` function finds a product by its ID, deletes it if found, and returns a JSON response indicating whether
  # the product was deleted or not.
  def delete
    @product = Product.find_by(id: params[:id])

    if @product
      @product.destroy

      render json: { msg: "Product deleted" }, status: :bad_request
    else
      render json: { msg: "Product not found" }, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:name, :desc, :price, :quantity, :category_id)
  end

  def update_params
    params.permit(:name, :desc, :price, :quantity, :category_id)
  end
end
