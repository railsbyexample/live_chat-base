class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages, dependent: :destroy

  has_many :user_1_conversations, class_name: 'Conversation', foreign_key: 'user_1_id', dependent: :destroy
  has_many :user_2_conversations, class_name: 'Conversation', foreign_key: 'user_2_id', dependent: :destroy

  def conversations
    Conversation.where 'user_1_id = :id or user_2_id = :id', id: self.id
  end

  def conversation_with user_id
    @conversations.find_by 'user_1_id = :id or user_2_id = :id', other_user_id: user_id
  end

  def gravatar_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=40"
  end

  def name
    email.split('@')[0]
  end
end
