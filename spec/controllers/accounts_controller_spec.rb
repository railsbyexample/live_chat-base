require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to be_successful
    end

    it 'renders the new account form' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:valid_account_attributes) { attributes_for :account }
    let(:valid_user_attributes) { attributes_for :user }

    it 'renders form again' do
      post :create, params: { account: valid_account_attributes, user: valid_user_attributes }
      expect(response).to redirect_to(new_account_path)
    end

    it 'creates a new account' do
      expect do
        post :create, params: { account: valid_account_attributes, user: valid_user_attributes }
      end.to change(Account, :count).by(1)
    end

    it 'creates a new tenant and an owner user within it' do
      post :create, params: { account: valid_account_attributes, user: valid_user_attributes }

      Apartment::Tenant.switch valid_account_attributes[:subdomain] do
        expect(User.find_by(email: valid_user_attributes[:email]).owner?)
          .to be(true)
      end
    end
  end
end
