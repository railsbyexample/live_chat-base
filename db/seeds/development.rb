require 'factory_girl'

# Clean up db
User.delete_all
Conversation.delete_all


# Development fake data
test_user_email = 'test.user@example.com'
test_user_password = 'password'

test_user_num = 5
test_conversation_num = 25

# Test user
User.create email: test_user_email, password: test_user_password, password_confirmation: test_user_password

# Sample users
test_user_num.times do
  FactoryGirl.create :user
end
users = User.all

# Sample conversations
test_conversation_num.times do
  # Get users for conversation
  user_1 = users.sample
  user_2 = users.sample
  # Retry if same user
  user_2 = users.sample while user_2.id == user_1.id
  # Create conversation
  Conversation.create user_1: user_1, user_2: user_2
end
conversations = Conversation.all

# Sample messages
conversations.each do |conversation|
  rand(0..20).times do
    rand(0..3).times do
      Message.create user: conversation.user_1, conversation: conversation, body: Faker::Lorem.paragraph(rand(2..8))
    end
    rand(0..2).times do
      Message.create user: conversation.user_2, conversation: conversation, body: Faker::Lorem.paragraph(rand(2..8))
    end
  end
end
