class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :messages, dependent: :destroy

  has_many :sent_contacts, class_name: 'Contact', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_contacts, class_name: 'Contact', foreign_key: 'receiver_id', dependent: :destroy

  def contacts
    Contact.where 'sender_id = :id or receiver_id = :id', id: id
  end

  def contact_with(user_id)
    contacts.find_by('receiver_id = :id OR sender_id = :id', id: user_id)
  end

  def confirmed_users
    contacts.includes(%i[sender receiver]).confirmed.find_each.map do |contact|
      contact.sender == self ? contact.receiver : contact.sender
    end
  end

  def gravatar_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=40"
  end

  def name
    return full_name if full_name.present?
    email.split('@')[0]
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
