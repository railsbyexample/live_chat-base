require 'factory_girl'

# Clean up db
User.destroy_all
Conversation.destroy_all
Message.destroy_all

# Development fake data
test_user_1_email = 'test.user1@example.com'
test_user_1_password = 'password'
test_user_2_email = 'test.user2@example.com'
test_user_2_password = 'password'

test_user_num = 5
test_conversation_num = 25

# Test users
User.create email: test_user_1_email, password: test_user_1_password, password_confirmation: test_user_1_password
User.create email: test_user_2_email, password: test_user_2_password, password_confirmation: test_user_2_password

# Sample users
test_user_num.times do
  FactoryBot.create :user
end
users = User.all

# # Sample conversations
# test_conversation_num.times do
#   # Get users for conversation
#   user_1 = users.sample
#   user_2 = users.sample
#   # Create conversation if it doesn't exist
#   if !(user_2.id == user_1.id or user_1.conversation_with(user_2.id))
#     Conversation.create user_1: user_1, user_2: user_2
#   end
# end
# conversations = Conversation.all
#
# # Sample messages
# conversations.each do |conversation|
#   rand(0..20).times do
#     rand(0..3).times do
#       Message.create user: conversation.user_1, conversation: conversation, body: Faker::Lorem.paragraph(rand(2..8))
#     end
#     rand(0..2).times do
#       Message.create user: conversation.user_2, conversation: conversation, body: Faker::Lorem.paragraph(rand(2..8))
#     end
#   end
# end
