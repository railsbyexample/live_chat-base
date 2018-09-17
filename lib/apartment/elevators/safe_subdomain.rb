require 'apartment/elevators/generic'

module Apartment
  module Elevators
    class SafeSubdomain < Apartment::Elevators::Generic
      def parse_tenant_name(request)
        host = request.host
        last_subdomain = host.gsub(ENV['app_host'], '').split('.').last

        last_subdomain.nil? || last_subdomain == 'www' ? 'public' : last_subdomain
      end
    end
  end
end
