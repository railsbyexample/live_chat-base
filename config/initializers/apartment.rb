require 'apartment/elevators/safe_subdomain'

# Apartment Configuration
Apartment.configure do |config|
  config.excluded_models = %w[Account]
  config.tenant_names = -> { Account.pluck :subdomain }
  config.prepend_environment = !Rails.env.production?
end

# Add SafeSubdomain elevator before Devise
Rails.application.configure do
  config.middleware
        .insert_before Warden::Manager, Apartment::Elevators::SafeSubdomain
end
