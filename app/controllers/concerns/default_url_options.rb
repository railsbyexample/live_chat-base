# Including this file sets the default url options. This is useful for mailers or background jobs
module DefaultUrlOptions
  def default_url_options
    {
      host: host,
      subdomain: subdomain
    }
  end

  private

  def subdomain
    (Apartment::Tenant.current == 'public' ? '' : Apartment::Tenant.current)
  end

  def host
    ENV['app_host_with_port']
  end
end
