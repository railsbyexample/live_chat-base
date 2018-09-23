json.extract! contact, :id, :sender_id, :receiver_id, :confirmed_at, :created_at, :updated_at
json.url contact_url(contact, format: :json)
