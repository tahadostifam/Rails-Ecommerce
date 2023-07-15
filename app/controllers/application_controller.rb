class ApplicationController < ActionController::API
  include ValidateParams
  include Authentication
end
