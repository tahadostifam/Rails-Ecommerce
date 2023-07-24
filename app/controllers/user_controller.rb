class UserController < ApplicationController
  before_action :authenticate_user!, only: [:authentication, :update_profile]

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
      if @user.confirmed?
        # Check user is banned or not
        if @user.locked?
          return render json: { msg: "Account locked" }, status: :unauthorized
        end

        # Success login
        login_user @user.id

        render template: 'api/users/index', status: :ok, locals: { msg: "Success" }
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
    @user = current_user
    render template: 'api/users/index', status: :ok, locals: { msg: "Success" }
  end

  ##
  # The `logout` function logs out the user and returns a JSON response with a success message.
  def logout
    logout_user

    render json: { msg: "Signed out" }, status: :ok
  end

  def update_profile
    @user = User.find_by(id: current_user.id)

    # Prevents of running update query for twice!
    if params[:phone_number]
      @user.unconfirm!
    end

    if @user && @user.update!(update_params[:user])
      @user.account_detail.update!(update_params[:account_detail])

      if params[:phone_number]
        @otp = PhoneOtp.find_or_initialize_by(phone_number: params[:phone_number])

        SmsClient.send_otp_code(params[:phone_number], @otp.otp_code)

        if @otp.save
          render json: { msg: "Account confirmation code sent" }, status: :ok
        else
          render json: { msg: "Unable to create otp record in database", detail: { errors: @otp.errors.full_messages } }, status: :bad_request
        end
      else
        render template: 'api/users/index', status: :ok, locals: { msg: "Profile updated" }
      end
    else
      render json: { msg: "Unable to update profile", detail: { errors: @user.errors.full_messages } }, status: :bad_request
    end
  end

  private

  def update_params
    params.permit(user: [:name, :last_name, :phone_number, :username], account_detail: [:address1, :address2, :postal_code])
  end

  def signup_params
    params.permit(:name, :last_name, :phone_number, :username, :password)
  end
end
