class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], conversation_id: data['conversation_id'])
  end
end
