class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum admin_level: { non_admin: 0, owner: 1 }

  has_many :messages, dependent: :destroy

  has_many :user_1_conversations, class_name: 'Conversation', foreign_key: 'user_1_id', dependent: :destroy
  has_many :user_2_conversations, class_name: 'Conversation', foreign_key: 'user_2_id', dependent: :destroy

  def conversations
    Conversation.where 'user_1_id = :id or user_2_id = :id', id: self.id
  end

  def conversation_with user_id
    self.conversations.find_by 'user_1_id = :id or user_2_id = :id', id: user_id
  end

  def gravatar_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=40"
  end

  def name
    email.split('@')[0]
  end
end
