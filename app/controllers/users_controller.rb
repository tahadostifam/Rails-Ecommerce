class UsersController < ApplicationController
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      render "users/login", status: :ok
    else
      render "users/unauthorized", status: :unauthorized
    end
  end

  def register
    @user = User.new(register_params)

    if @user.save
      render "users/created", status: :ok
    else
      render "common/errors", status: :bad_request, locals: { errors: @user.errors }
    end
  end

  def authenticate
  end

  private

  def register_params
    params.permit(:name, :email, :password)
  end
end
