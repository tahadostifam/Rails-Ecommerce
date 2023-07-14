require "dry-schema"

module ValidateParams
  extend ActiveSupport::Concern

  def sample
    puts "hello"
  end

  def validate_params!(schema, params)
    symbolized_params = symbolize_params(params)

    errors = schema.call(symbolized_params).errors.to_h

    unless errors.empty?
      render json: { errors: errors }, status: :bad_request
    else
      yield
    end
  end

  private

  def symbolize_params(params)
    params_hash = {}
    params.each do |k, v|
      params_hash[k.to_sym] = v
    end
    return params_hash
  end
end
