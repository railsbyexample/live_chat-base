class SessionsController < Devise::SessionsController

  private

  def after_sign_in_path_for(resource)
    contacts_path
  end
end
