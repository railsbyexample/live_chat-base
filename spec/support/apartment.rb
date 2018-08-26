RSpec.configure do |config|
  config.before(:suite) do
    Apartment::Tenant.drop 'test-tenant' rescue nil
    Apartment::Tenant.create 'test-tenant'

    Account.destroy_all
    FactoryBot.create :account, subdomain: 'test-tenant'
  end
end
