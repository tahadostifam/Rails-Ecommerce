class UserController < ApplicationController
  def login_by_username
    validate_params!(LoginByUsernameSchema, params.permit(:username, :password)) {
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        login(user.id)

        render json: { user: user }, status: :ok
      else
        render json: { msg: "Unauthorized" }, status: :unauthorized
      end
    }
  end
end
