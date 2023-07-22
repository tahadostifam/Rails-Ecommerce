class ProductController < ApplicationController
  ##
  # The index function retrieves the last 50 products and renders them as JSON.
  def index
    @products = Product.last(50)

    render template: 'api/product/index', status: :ok
  end
end
