class UserController < ApplicationController
  def signup
    validate_params!(SignupSchema, params) {
      @user = User.new(signup_params)

      if @user.save
        # TODO
        # - Send sms to client's phone!

        render json: { msg: "Account created" }, status: :ok
      else
        internal_server_error
      end
    }
  end

  def login
    validate_params!(LoginByUsernameSchema, params) {
      @user = User.find_by(username: params[:username])

      if @user && @user.authenticate(params[:password])
        login_user @user.id

        render json: UserPresenter.to_json(@user), status: :ok
      else
        render json: { msg: "Unauthorized" }, status: :unauthorized
      end
    }
  end

  def authentication
    if user_signed_in?
      render json: UserPresenter.to_json(current_user), status: :ok
    else
      render json: { msg: "Unauthorized" }, status: :unauthorized
    end
  end

  def logout
    logout_user
    render json: { msg: "Logout" }, status: :ok
  end

  private

  def signup_params
    params.permit(:name, :last_name, :phone_number, :username, :password)
  end
end
