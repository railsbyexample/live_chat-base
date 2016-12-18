module DeviseHelper
  def devise_error_messages!
    flash_alerts = []

    if !flash.empty?
      flash_alerts.push(flash[:error]) if flash[:error]
      flash_alerts.push(flash[:alert]) if flash[:alert]
      flash_alerts.push(flash[:notice]) if flash[:notice]
    end

    return "" if resource.errors.empty? && flash_alerts.empty?
    messages = resource.errors.empty? ? flash_alerts : resource.errors.full_messages

    render partial: 'shared/errors', locals: { messages: messages }
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end
