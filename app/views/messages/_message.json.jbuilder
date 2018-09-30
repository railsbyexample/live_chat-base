json.id message.id
json.contact_id message.contact_id
json.user_id message.user_id

json.user do
  json.partial! 'users/user', user: message.user
end

json.body message.body
