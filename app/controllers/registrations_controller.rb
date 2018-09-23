class RegistrationsController < Devise::RegistrationsController

  private

  def after_inactive_sign_up_path_for(_resource)
    new_user_registration_path
  end
end
