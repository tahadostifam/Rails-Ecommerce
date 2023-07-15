class UserController < ApplicationController
  def signup
    validate_params!(SignupSchema, signup_params) {
      user = User.new(signup_params)

      if user.save
        render json: { msg: "Account created" }, status: :ok
      else
        errors = user.errors.full_messages
        render json: { errors: errors }, status: :internal_server_error
      end
    }
  end

  def login_by_username
    validate_params!(LoginByUsernameSchema, params.permit(:username, :password)) {
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        login_user user.id

        response_user_info user
      else
        render json: { msg: "Unauthorized" }, status: :unauthorized
      end
    }
  end

  def authentication
    if user_signed_in?
      response_user_info current_user
    else
      render json: { msg: "Unauthorized" }, status: :unauthorized
    end
  end

  def logout
    logout_user
  end

  private

  def response_user_info(user)
    user = user.attributes

    user.delete "password"
    user.delete "password_digest"
    user.delete "created_at"
    user.delete "updated_at"

    render json: { user: user }, status: :ok
  end

  def signup_params
    params.permit(:name, :last_name, :phone_number, :username, :password)
  end
end
