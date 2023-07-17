class ProductController < ApplicationController
  before_action :login_required, except: [:index]
  before_action -> { limit_access(action_name, :seller) }, only: [:create, :update, :delete]

  ##
  # The index function retrieves the last 50 products and renders them as JSON.
  def index
    @products = Product.last(50)

    render json: { products: @products }
  end

  ##
  # The `create` function creates a new product and associates it with a category and discount, if provided, and returns a
  # JSON response with the product details.
  def create
    validate_params!(CreateProductSchema, params) {
      @product = Product.new(create_params)
      @category = Category.find_by(id: params[:category_id])
      @discount = Discount.find_by(id: params[:discount_id])

      unless @category.nil?
        if @product.save
          detail = { :category => { name: @category.name, is_available: @category.is_available } }

          if @discount
            detail[:discount] = {
              name: @discount.name,
              discount_percent: @discount.discount_percent,
              expires_at: @discount.discount_percent,
            }
          end

          render json: { msg: "Product created", detail: detail }, status: :created
        else
          internal_server_error
        end
      else
        render json: { msg: "Category not found" }, status: :bad_request
      end
    }
  end

  ##
  # The `update` function updates a product with the given parameters, including the category and discount if provided,
  # and returns a JSON response with the updated product details.
  #
  # Returns:
  #   The code is returning a JSON response with a message and details about the updated product, category, and discount.
  # The status code of the response depends on the outcome of the update operation.
  def update
    validate_params!(UpdateProductSchema, params) {
      @product = Product.find_by(id: params[:id])

      if params[:category_id]
        @category = Category.find_by(id: params[:category_id])
        unless @category
          return render json: { msg: "Category not found" }, status: :bad_request
        end
      end

      if params[:discount_id]
        @discount = Discount.find_by(id: params[:discount_id])
        unless @discount
          return render json: { msg: "Discount not found" }, status: :bad_request
        end
      end

      if @product
        if @product.update(update_params)
          detail = { product: @product }

          if @category
            detail[:category] = { name: @category.name, is_available: @category.is_available }
          end

          if @discount
            detail[:discount] = {
              name: @discount.name,
              discount_percent: @discount.discount_percent,
              expires_at: @discount.discount_percent,
            }
          end

          render json: { msg: "Product updated", detail: detail }, status: :ok
        else
          internal_server_error
        end
      else
        render json: { msg: "Product not found" }, status: :bad_request
      end
    }
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
    params.permit(:name, :desc, :price, :quantity, :category_id, :discount_id)
  end

  def update_params
    params.permit(:name, :desc, :price, :quantity, :category_id, :discount_id)
  end
end
