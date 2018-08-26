module HandlePublicTenant
  extend ActiveSupport::Concern

  def block_tenant
    return if Apartment::Tenant.current == 'public'
    redirect_to root_path
  end

  def block_public
    return unless Apartment::Tenant.current == 'public'
    redirect_to root_path
  end
end
