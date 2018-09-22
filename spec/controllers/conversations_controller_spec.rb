require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  describe 'POST /conversations' do
    describe 'when conversation with user already exists' do
      let(:user_1) { create :user }
      let(:user_2) { create :user }

      let!(:conversation) { create :conversation, user_1: user_1, user_2: user_2 }

      before(:each) { sign_in user_1 }

      it 'renders the existing conversation for ordered users' do
        post :create, params: { conversation: { user_1_id: user_1.id, user_2_id: user_2.id } }
        expect(response).to redirect_to(conversation)
      end

      it 'renders the existing conversation for inverted users' do
        post :create, params: { conversation: { user_1_id: user_2.id, user_2_id: user_1.id } }
        expect(response).to redirect_to(conversation)
      end
    end

    describe 'when no conversation with user exists' do
      let(:user_1) { create :user }
      let(:user_2) { create :user }

      before(:each) { sign_in user_1 }

      it 'creates a new conversation' do
        expect do
          post :create, params: { conversation: { user_1_id: user_1.id, user_2_id: user_2.id } }
        end.to change(Conversation, :count).by(1)
      end
    end
  end
end
