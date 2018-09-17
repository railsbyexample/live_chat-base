class ApplicationController < ActionController::Base
  include HasAuthorization
  include HasTenant

  protect_from_forgery with: :exception

  helper_method :app_host_with_port
  def app_host_with_port
    request.host_with_port
  end
end
