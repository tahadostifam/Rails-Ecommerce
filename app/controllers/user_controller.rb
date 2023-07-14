class UserController < ApplicationController
  def login_by_username
    validate_params!(LoginByUsernameSchema, params.permit(:username, :password)) {
      render json: { msg: "Method not implemented yet." }
    }
  end
end
