module HasTenant
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

  def on_public_tenant?
    Apartment::Tenant.current == 'public'
  end

  def on_private_tenant?
    current_organization.present?
  end

  def block_private_tenant!
    return if Apartment::Tenant.current == 'public'
    redirect_to root_path
  end

  def block_public_tenant!
    return unless Apartment::Tenant.current == 'public'
    redirect_to root_path
  end
end
