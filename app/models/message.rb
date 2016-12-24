class Message < ApplicationRecord
  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  belongs_to :user
  belongs_to :conversation

  def get_user conversation
    self.user_id == conversation.user_1_id ? conversation.user_1 : conversation.user_2
  end

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
