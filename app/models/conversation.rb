class Conversation < ApplicationRecord
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
  has_many :messages, dependent: :destroy
  default_scope { includes(:user_1, :user_2) }

  def last_message
    messages.includes(:user).last
  end
end
