module HasAuthorization
  extend ActiveSupport::Concern

  def authorize_owner!
    redirect_to root_url unless current_user.owner?
  end
end
