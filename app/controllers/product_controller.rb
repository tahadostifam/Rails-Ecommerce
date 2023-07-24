class ProductController < ApplicationController
  authorize_resource

  ##
  # The index function retrieves the last 50 products and renders them as JSON.
  def index
    @products = Product.all

    render template: 'api/products/index', status: :ok, locals: { msg: "Success" }
  end
end
