class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    message_data = render_message(message)

    ActionCable.server.broadcast "users_#{message.contact.sender.id}_channel", message: message_data
    ActionCable.server.broadcast "users_#{message.contact.receiver.id}_channel", message: message_data
  end

  def render_message(message)
    ApplicationController.render json: message.to_json(include: { user: { methods: [:name, :gravatar_url] } })
  end
end
