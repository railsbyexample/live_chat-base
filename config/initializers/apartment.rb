require 'apartment/elevators/subdomain'

# Apartment Configuration
Apartment.configure do |config|
  config.excluded_models = %w[Account]
  config.tenant_names = -> { Account.pluck :subdomain }
  config.prepend_environment = !Rails.env.production?
end

# Add Subdomain elevator before Devise
Rails.application.configure do
  # TODO: fix custom elevator that works with localhost
  if Rails.env.development? || Rails.env.test?
    custom_elevator = proc do |request|
      subdomain = request.host == 'localhost' ? 'public' : request.host.split('.').first
      subdomain == 'www' ? 'public' : subdomain
    end

    config.middleware
         .insert_before(
           Warden::Manager,
           Apartment::Elevators::Subdomain,
           custom_elevator
         )
  else
    config.middleware
          .insert_before Warden::Manager, Apartment::Elevators::Subdomain
    Apartment::Elevators::Subdomain.excluded_subdomains = %w[www]
  end
end
