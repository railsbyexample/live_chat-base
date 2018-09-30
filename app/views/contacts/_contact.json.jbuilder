included ||= {}

json.id contact.id
json.sender_id contact.sender_id
json.receiver_id contact.receiver_id

json.sender do
  json.partial! 'users/user', user: contact.sender
end

json.receiver do
  json.partial! 'users/user', user: contact.receiver
end

if included.try(:include?, :last_message) && contact.last_message
  json.last_message do
    json.partial! 'messages/message', message: contact.last_message
  end
end

if included.try(:include?, :messages)
  json.messages do
    json.partial! 'messages/message', collection: contact.messages, as: :message
  end
end
