module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    render partial: 'shared/errors', locals: { messages: resource.errors.full_messages }
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end
