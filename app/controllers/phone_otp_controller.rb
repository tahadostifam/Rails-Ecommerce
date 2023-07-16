class PhoneOtpController < ApplicationController
  def login_by_phone
    validate_params!(LoginByPhoneSchema, params) {
      @otp = PhoneOtp.find_or_initialize_by(phone_number: params[:phone_number])
      @otp.expires_at = PhoneOtp.generate_expires_at
      @otp.otp_code = PhoneOtp.generate_otp_code

      # TODO
      # - Send sms to client's phone!

      @otp.save

      render json: { msg: "Code sent" }, status: :ok
    }
  end

  def verify_otp_code
    validate_params!(VerifyOtpCodeSchema, params) {
      @otp = PhoneOtp.find_by(phone_number: params[:phone_number])

      if @otp && @otp.otp_code == params[:otp_code]
        @user = User.find_by(phone_number: params[:phone_number])

        if @user
          # Success Verification
          login_user @user.id
          render json: UserPresenter.to_json(@user), status: :ok

          # Destroying Otp Code
          @otp.destroy
        else
          render json: { msg: "Unauthorized" }, status: :unauthorized
        end
      else
        render json: { msg: "Unauthorized" }, status: :unauthorized
      end
    }
  end
end
