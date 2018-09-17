module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :tenant

    def connect
      self.tenant = request.host.split('.').first

      Apartment::Tenant.switch tenant do
        self.current_user = find_verified_user
        logger.add_tags 'ActionCable', current_user.email
      end
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
