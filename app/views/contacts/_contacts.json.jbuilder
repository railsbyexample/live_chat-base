included ||= {}

json.array!(contacts) do |contact|
  json.partial! 'contacts/contact', contact: contact, included: included.fetch(:contact, nil)
end
