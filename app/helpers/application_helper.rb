module ApplicationHelper
  def gravatar_for(user, opts = {})
    image_tag user ? "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}" : '', opts
  end

  def application_title
    Apartment::Tenant.current == 'public' ? 'MessRb' : "#{Apartment::Tenant.current.titleize} on MessRb"
  end

  def form_group(field_name, field_type, form, options={})
    render partial: 'shared/form_group',
           locals: {
             field_name: field_name,
             field_type: field_type,
             form: form,
             options: options
           }
  end

  def form_button(text, form)
    render partial: 'shared/form_button',
           locals: { text: text, form: form }
  end
end
