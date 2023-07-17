class CartController < ApplicationController
  before_action :login_required

  def index
    @session = Session.find_or_initialize_by(user_id: current_user.id)

    @items = CartPresenter.to_json(@session.cart_items)

    render json: { msg: "Success", detail: { items: @items } }, status: :ok
  end

  def add_item
    validate_params!(AddItemToCartSchema, params) {
        @session = Session.find_or_initialize_by(user_id: current_user.id)

        @item = CartItem.find_or_initialize_by(product_id: params[:product_id])
        @item.quantity = params[:quantity]
        @item.session_id = @session.id

        if @item.save
          render json: { msg: "Item added" }, status: :ok
        else
          render json: { msg: "Unable to add item", detail: { errors: @item.errors } }, status: :ok
        end
      }
  end

  def remove_item
      validate_params!(RemoveCartItem, params) {
        @item = CartItem.find_by(id: params[:item_id])

        if @item
          @item.destroy

          render json: { msg: "Item removed" }, status: :ok
        else
          render json: { msg: "Item not found" }, status: :bad_request
        end
      }
  end

  def update_item
    validate_params!(UpdateCartItem, params) {
        @item = CartItem.find_by(id: params[:item_id])

        if @item
          @item.update(quantity: params[:quantity])

          render json: { msg: "Item updated" }, status: :ok
        else
          render json: { msg: "Item not found" }, status: :bad_request
        end
      }
  end

  private

  def update_params
    params.permit(:item_id, :quantity)
  end
end
