class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :user_1_conversations, class_name: 'Conversation', foreign_key: 'user_1_id', dependent: :destroy
  has_many :user_2_conversations, class_name: 'Conversation', foreign_key: 'user_2_id', dependent: :destroy

  def conversations
    Conversation.where('user_1_id = ? or user_2_id = ?', self.id, self.id)
  end

  def conversation_with user_id
    Conversation.find_by(
      '(user_1_id = :id_1 and user_2_id = :id_2) or (user_2_id = :id_1 and user_1_id = :id_2)',
      id_1: self.id, id_2: user_id)
  end

  def name
    email.split('@')[0]
  end
end
