class ApplicationController < ActionController::Base
  include HandlePublicTenant
  include HandleTenant
  include HandleAuthorizationExceptions

  protect_from_forgery with: :exception
end
