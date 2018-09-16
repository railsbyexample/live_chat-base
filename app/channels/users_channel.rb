class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_#{current_user.id}_channel"
  end

  def unsubscribed; end

  def send_message(data)
    Apartment::Tenant.switch tenant do
      current_user.messages.create!(
        body: data['body'],
        conversation_id: data['conversation_id']
      )
    end
  end
end
