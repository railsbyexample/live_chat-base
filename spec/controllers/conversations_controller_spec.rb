require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  describe 'POST /conversations' do

    describe 'when conversation with user already exists' do
      before :each do
        @user_1 = create :user
        @user_2 = create :user
        conversation = create :conversation, user_1: @user_1, user_2: @user_2

        sign_in @user_1
      end

      it 'should render the existing conversation for ordered users' do
        post :create, params: { conversation: { user_1_id: @user_1.id, user_2_id: @user_2.id } }
        assert_response :ok
      end

      it 'should render the existing conversation for inverted users' do
        post :create, params: { conversation: { user_1_id: @user_2.id, user_2_id: @user_1.id } }
        assert_response :ok
      end
    end

    describe 'when no conversation with user exists' do
      before :each do
        @user_1 = create :user
        @user_2 = create :user

        sign_in @user_1
      end

      it 'should render the existing conversation for ordered users' do
        post :create, params: { conversation: { user_1_id: @user_1.id, user_2_id: @user_2.id } }
        assert_response :created
      end

      it 'should render the existing conversation for inverted users' do
        post :create, params: { conversation: { user_1_id: @user_2.id, user_2_id: @user_1.id } }
        assert_response :success
      end
    end

  end
end
