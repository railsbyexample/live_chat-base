class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "users_#{message.conversation.user_1_id}_channel", message: render_message(message)
    ActionCable.server.broadcast "users_#{message.conversation.user_2_id}_channel", message: render_message(message)
  end

  def render_message(message)
    MessagesController.render json: message.to_json(include: { user: { methods: [:name, :gravatar_url] } })
  end
end
