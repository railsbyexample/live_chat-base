require 'rails_helper'

RSpec.describe Auth::InvitationsController, type: :controller do
  def set_devise_mapping
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:user) { create :user }
    before(:each) { sign_in(user) }

    it 'creates the new user' do
      set_devise_mapping

      post :create, params: { user: { email: 'test@email.com' } }

      expect(User.find_by(email: 'test@email.com').persisted?).to be(true)
    end

    it 'redirects to the users index' do
      set_devise_mapping

      post :create, params: { user: { email: 'test@email.com' } }

      expect(response).to redirect_to(users_url)
    end
  end

  describe 'PATCH #update' do
    it 'activates the new user' do
      set_devise_mapping
      user = User.invite!(email: 'test@email.com', &:skip_invitation)

      patch :update, params: {
        user: {
          invitation_token: user.raw_invitation_token,
          password: 'password',
          password_confirmation: 'password',
        }
      }

      expect(user.reload.invitation_accepted?).to be(true)
    end

    it 'redirects to root' do
      set_devise_mapping
      user = User.invite!(email: 'test@email.com', &:skip_invitation)

      patch :update, params: {
        user: {
          invitation_token: user.raw_invitation_token,
          password: 'password',
          password_confirmation: 'password'
        }
      }

      expect(response).to redirect_to(root_url)
    end
  end

  describe 'GET #new' do
    context 'with a user signed in' do
      let(:user) { create :user }
      before(:each) { sign_in(user) }

      it 'renders user invitation form' do
        set_devise_mapping
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'without a user signed in' do
      it 'redirects to root' do
        set_devise_mapping
        get :new
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
