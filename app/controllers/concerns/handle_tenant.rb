module HandleTenant
  extend ActiveSupport::Concern

  included do
    helper_method :current_organization
    helper_method :tenant_site?
  end

  def current_organization
    tenant = Apartment::Tenant.current
    @current_organization ||=
      (tenant == 'public' ? nil : Organization.find_by(subdomain: tenant))
  end

  def tenant_site?
    current_organization.present?
  end
end
