require 'apartment/elevators/generic'

module Apartment
  module Elevators
    class SafeSubdomain < Apartment::Elevators::Generic
      def parse_tenant_name(request)
        host = request.host
        last_subdomain = host.gsub(ENV['app_host'], '').split('.').last

        tenant_name = last_subdomain.nil? || last_subdomain == 'www' ? 'public' : last_subdomain

        puts "[TENANT NAME] #{tenant_name}"

        tenant_name
      end
    end
  end
end
