module Auth
  class InvitationsController < Devise::InvitationsController
    before_action :block_public
    before_action :authorize_owner!, only: %i[new create]

    def create
      super do |user|
        user.admin_level = :admin
        user.save(validate: false)
      end
    end

    private

    def after_invite_path_for(_user)
      users_path
    end

    # Only allow superadmin to invite new users
    def authenticate_inviter!
      return if current_user.try(:owner?)
      redirect_to(root_url) && return
    end
  end
end
