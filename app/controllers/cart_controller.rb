class CartController < ApplicationController
  before_action :login_required

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
end
