class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users_#{current_user.id}_channel"
  end

  def unsubscribed; end

  def send_message(data)
    Message.create!(
      body: data['body'],
      user_id: current_user.id,
      contact_id: data['contact_id']
    )
  end
end
