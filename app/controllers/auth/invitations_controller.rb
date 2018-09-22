module Auth
  class InvitationsController < Devise::InvitationsController
    before_action :authenticate_user!

    private

    def after_invite_path_for(_user)
      users_path
    end

    # Only allow signed in users to invite others
    def authenticate_inviter!
      authenticate_user!
    end
  end
end
