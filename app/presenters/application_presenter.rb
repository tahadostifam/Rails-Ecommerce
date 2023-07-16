class ApplicationPresenter
  def self.internal_server_error
    render json: { msg: "Internal server error" }, status: :internal_server_error
  end
end
