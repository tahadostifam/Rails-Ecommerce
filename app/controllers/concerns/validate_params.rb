require "dry-schema"

module ValidateParams
  extend ActiveSupport::Concern

  ##
  # The function `symbolize_params` converts the keys of a hash from strings to symbols.
  #
  # Args:
  #   params: The `params` parameter is a hash that contains key-value pairs.
  #
  # Returns:
  #   The method is returning a hash where the keys are symbols and the values are the same as the original values in the
  # params hash.
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

  ##
  # The function `symbolize_params` converts the keys of a hash from strings to symbols.
  #
  # Args:
  #   params: The `params` parameter is a hash that contains key-value pairs.
  #
  # Returns:
  #   The method is returning a hash where the keys are symbols and the values are the same as the original values in the
  # params hash.
  def symbolize_params(params)
    params_hash = {}
    params.each do |k, v|
      params_hash[k.to_sym] = v
    end
    return params_hash
  end
end
