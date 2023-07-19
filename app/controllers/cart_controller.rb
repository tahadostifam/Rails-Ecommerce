class CartController < ApplicationController
  before_action :login_required

  ##
  # The `index` function retrieves the user's session and cart items, converts them to JSON format using a presenter, and
  # renders a JSON response with the items and total.
  def index
    @session = Session.find_or_initialize_by(user_id: current_user.id)

    @items = CartPresenter.to_json(@session.cart_items)

    render json: { msg: "Success", detail: { items: @items, total: @session.total } }, status: :ok
  end

  ##
  # The `add_item` function adds a product to the user's cart and updates the cart's total.
  def add_item
    @session = Session.find_by(user_id: current_user.id)

    unless @session
      @session = Session.create!(user_id: current_user.id)
    end

    @item = CartItem.find_by(product_id: params[:product_id])

    if @item
      @item.quantity += params[:quantity]
    else
      @item = CartItem.create!(product_id: params[:product_id], session_id: @session.id, quantity: params[:quantity])
    end

    if @item.save
      @session.compute_total
      @session.save

      render json: { msg: "Item added" }, status: :ok
    else
      render json: { msg: "Unable to add item", detail: { errors: @item.errors } }, status: :bad_request
    end
  end

  ##
  # The `remove_item` function removes a cart item from the database and returns a JSON response indicating whether the
  # item was successfully removed or not.
  def remove_item
    @item = CartItem.find_by(id: params[:item_id])

    if @item
      @item.destroy

      render json: { msg: "Item removed" }, status: :ok
    else
      render json: { msg: "Item not found" }, status: :bad_request
    end
  end

  ##
  # The `update_item` function updates the quantity of a cart item and computes the total for the session it belongs to.
  def update_item
    @item = CartItem.find_by(id: params[:item_id])

    if @item
      if @item.update(quantity: params[:quantity])
        @item.session.compute_total
        @item.session.save

        render json: { msg: "Item updated" }, status: :ok
      else
        render json: { msg: "Unable to add item", detail: { errors: @item.errors } }, status: :bad_request
      end
    else
      render json: { msg: "Item not found" }, status: :bad_request
    end
  end

  private

  def update_params
    params.permit(:item_id, :quantity)
  end
end
