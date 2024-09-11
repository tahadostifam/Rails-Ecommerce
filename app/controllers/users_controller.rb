class UsersController < ApplicationController
  include Auth

  before_action :authenticated?, only: [ :authenticate, :update_profile ]

  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render "users/user", status: :ok, locals: { user: user }
    else
      render "users/unauthorized", status: :unauthorized
    end
  end

  def register
    user = User.new(register_params)

    if user.save
      render json: { msg: "created" }, status: :ok
    else
      render "common/errors", status: :bad_request, locals: { errors: user.errors }
    end
  end

  def authenticate
    user = active_user
    if user
      render "users/user", status: :ok, locals: { user: user }
    else
      render "users/unauthorized", status: :unauthorized
    end
  end

  def update_profile
    if active_user.update(update_profile_params)
      render json: { msg: "profile updated" }, status: :ok
    else
      render "common/errors", status: :bad_request, locals: { errors: active_user.errors }
    end
  end

  private

  def register_params
    params.permit(:name, :email, :password)
  end

  def update_profile_params
    params.permit(:name, :location, :city)
  end
end
