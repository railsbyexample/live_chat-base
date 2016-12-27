class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_#{current_user.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['body'], conversation_id: data['conversation_id'])
  end
end
