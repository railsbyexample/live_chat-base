class ApplicationController < ActionController::Base
  include HasAuthorization
  include HasTenant

  protect_from_forgery with: :exception
end
