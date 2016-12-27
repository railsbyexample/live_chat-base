class Message < ApplicationRecord
  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  belongs_to :user
  belongs_to :conversation

  default_scope do
    order(:created_at)
    includes(:user)
  end

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
