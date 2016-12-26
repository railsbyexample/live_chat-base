class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "conversations_#{message.conversation_id}_channel", message: render_message(message)
  end

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: { message: message }
  end
end
