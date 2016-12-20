require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    user = build :user
    expect(user).to be_valid
  end

  describe 'User#conversations' do
    it 'should return all of a user\'s conversations' do
      user = create :user, :with_conversations
      expected_conversations_length = user.user_1_conversations.length + user.user_2_conversations.length

      expect(user.conversations.length).to eq expected_conversations_length
    end
  end

  describe 'User#conversation_with(other_user)' do
    it 'should return the conversation with a given user if one exists' do
      user_1 = create :user
      user_2 = create :user
      conversation = create :conversation, user_1: user_1, user_2: user_2

      expect((user_1.conversation_with user_2.id).id).to eq conversation.id
    end

    it 'should return nil if no conversations with given user' do
      user_1 = create :user
      user_2 = create :user

      expect(user_1.conversation_with user_2.id).to eq nil
    end
  end
end
