class PhoneOtpController < ApplicationController
  ##
  # The `login_by_phone` function generates and sends an OTP code to a user's phone number for phone-based login.
  def login_by_phone
    @otp = PhoneOtp.find_or_initialize_by(phone_number: params[:phone_number])

    SmsClient.send_otp_code(params[:phone_number], @otp.otp_code)

    if @otp.save
      render json: { msg: "Code sent" }, status: :ok
    else
      render json: { msg: "Unable to create otp record in database", detail: { errors: @otp.errors.full_messages } }, status: :bad_request
    end
  end

  ##
  # The `verify_otp_code` function checks if the provided OTP code matches the one stored in the database for a given
  # phone number, and if so, verifies the user's account and logs them in.
  #
  # Returns:
  #   The method is returning a JSON response with a message and a status code. The specific JSON response depends on the
  # conditions met within the method.
  def verify_otp_code
    @otp = PhoneOtp.find_by(phone_number: params[:phone_number])

    if @otp && @otp.otp_code == params[:otp_code]
      if @otp.expired?
        @otp.destroy
        return render json: { msg: "Otp code expired" }, status: :unauthorized
      end

      @user = User.find_by(phone_number: params[:phone_number])

      if @user
        # Check user is banned or not
        if @user.is_banned?
          return render json: { msg: "Account banned" }, status: :unauthorized
        end

        # Set account confirmed to True!
        unless @user.is_confirmed?
          @user.update(is_confirmed: true)
        end

        # Success
        login_user @user.id
        render json: { msg: "Success", detail: { user: @user.as_json } }, status: :ok

        # Destroying Otp Code
        @otp.destroy
      else
        render json: { msg: "User not found" }, status: :unauthorized
      end
    else
      render json: { msg: "Unauthorized" }, status: :unauthorized
    end
  end
end
