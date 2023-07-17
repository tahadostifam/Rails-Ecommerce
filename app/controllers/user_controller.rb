class UserController < ApplicationController
  before_action :login_required, only: [:authentication]

  def signup
    validate_params!(SignupSchema, params) {
      @user = User.new(signup_params)

      if @user.save
        @otp = PhoneOtp.find_or_initialize_by(phone_number: params[:phone_number])
        @otp.expires_at = PhoneOtp.generate_expires_at
        @otp.otp_code = PhoneOtp.generate_otp_code

        SmsClient.send_otp_code(params[:phone_number], @otp.otp_code)

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
        if @user.is_confirmed?
          # Check user is banned or not
          if @user.is_banned?
            return render json: { msg: "Account banned" }, status: :unauthorized
          end

          # Success login
          login_user @user.id

          render json: UserPresenter.to_json(@user), status: :ok
        else
          render json: { msg: "Account did not confirmed" }, status: :unauthorized
        end
      else
        render json: { msg: "Unauthorized" }, status: :unauthorized
      end
    }
  end

  def authentication
    render json: UserPresenter.to_json(current_user), status: :ok
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
