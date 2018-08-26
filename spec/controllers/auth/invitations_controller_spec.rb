require 'rails_helper'

RSpec.describe Auth::InvitationsController, type: :controller do
  def set_devise_mapping
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context 'without a subdomain' do
    describe 'GET #new' do
      it 'redirects to root' do
        set_devise_mapping
        get :new
        expect(response).to redirect_to(root_url)
      end
    end

    describe 'POST #create' do
      it 'redirects to root' do
        set_devise_mapping
        post :create
        expect(response).to redirect_to(root_url)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to root' do
        set_devise_mapping
        patch :update
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'POST #create' do
    before(:each) { Apartment::Tenant.switch! 'test-tenant' }
    after(:each) { Apartment::Tenant.switch! }

    let(:owner) { create :user, admin_level: :owner }
    before(:each) { sign_in(owner) }

    it 'creates the new user as an admin' do
      set_devise_mapping

      post :create, params: { user: { email: 'test@email.com' } }

      expect(User.find_by(email: 'test@email.com').admin?).to be(true)
    end

    it 'redirects to the users index' do
      set_devise_mapping

      post :create, params: { user: { email: 'test@email.com' } }

      expect(response).to redirect_to(users_url)
    end
  end

  describe 'PATCH #update' do
    before(:each) { Apartment::Tenant.switch! 'test-tenant' }
    after(:each) { Apartment::Tenant.switch! }
    let(:organization) { Organization.find_by(subdomain: Apartment::Tenant.current) }

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
    before(:each) { Apartment::Tenant.switch! 'test-tenant' }
    after(:each) { Apartment::Tenant.switch! }

    context 'with an owner signed in' do
      let(:owner) { create :user, admin_level: :owner }
      before(:each) { sign_in(owner) }

      it 'renders user invitation form' do
        set_devise_mapping
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'with an admin signed in' do
      let(:user) { create :user, admin_level: :admin }
      before(:each) { sign_in(user) }

      it 'redirects to root' do
        get :new
        expect(response).to redirect_to(root_url)
      end
    end

    context 'without a user signed in' do
      it 'redirects to root' do
        get :new
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
