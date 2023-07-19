class UserController < ApplicationController
  before_action :login_required, only: [:authentication]

  ##
  # The `signup` function creates a new user account, generates an OTP (one-time password) code, sends the OTP code to the
  # user's phone number via SMS, and returns a JSON response indicating the success or failure of the account creation.
  def signup
    @user = User.new(signup_params)

    if @user.save
      @otp = PhoneOtp.find_or_initialize_by(phone_number: params[:phone_number])
      @otp.expires_at = PhoneOtp.generate_expires_at
      @otp.otp_code = PhoneOtp.generate_otp_code

      SmsClient.send_otp_code(params[:phone_number], @otp.otp_code)

      render json: { msg: "Account created" }, status: :ok
    else
      render json: { msg: "Unable to create account", detail: { errors: @user.errors.full_messages } }, status: :bad_request
    end
  end

  ##
  # The `login` function checks if a user's login credentials are valid, and if so, logs them in and returns their user
  # information in JSON format.
  #
  # Returns:
  #   The code is returning a JSON response with a message and a status code. The specific response depends on the
  # conditions met in the code:
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      if @user.is_confirmed?
        # Check user is banned or not
        if @user.is_banned?
          return render json: { msg: "Account banned" }, status: :unauthorized
        end

        # Success login
        login_user @user.id

        render json: { msg: "Success", detail: { user: @user.as_json } }, status: :ok
      else
        render json: { msg: "Account did not confirmed" }, status: :unauthorized
      end
    else
      render json: { msg: "Unauthorized" }, status: :unauthorized
    end
  end

  ##
  # The function "authentication" renders the current user as JSON with a status of "ok".
  def authentication
    render json: { msg: "Success", detail: { user: current_user.as_json } }, status: :ok
  end

  ##
  # The `logout` function logs out the user and returns a JSON response with a success message.
  def logout
    logout_user
    render json: { msg: "Logout" }, status: :ok
  end

  private

  def signup_params
    params.permit(:name, :last_name, :phone_number, :username, :password)
  end
end
