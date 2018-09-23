require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe 'GET #index' do
    let(:user) { create :user }
    before(:each) { sign_in user }

    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    let(:user) { create :user }
    before(:each) { sign_in user }

    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    let(:user) { create :user }
    before(:each) { sign_in user }

    it 'returns a success response' do
      contact = create :contact, sender: user
      get :edit, params: { id: contact.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:sender) { create :user }
    before(:each) { sign_in sender }

    context 'with an existing user' do
      let(:receiver) { create :user }
      let(:valid_attributes) { { email: receiver.email } }

      it 'creates a new Contact' do
        expect do
          post :create, params: { contact: valid_attributes }
        end.to change(Contact, :count).by(1)
      end

      it 'redirects to the users index' do
        post :create, params: { contact: valid_attributes }
        expect(response).to redirect_to(users_url)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { email: 'nonemail' } }

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { contact: invalid_attributes }
        expect(response).to redirect_to(new_contact_url)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create :user }
    let(:sender) { create :user }
    let(:receiver) { create :user }
    let!(:contact) { create :contact, sender: sender, receiver: receiver }

    context "the contact's receiver is signed in" do
      before(:each) { sign_in receiver }

      it 'confirms the requested contact' do
        patch :update, params: { id: contact.to_param }
        expect(contact.reload.confirmed?).to be(true)
      end
    end

    context "the contact's sender is signed in" do
      before(:each) { sign_in sender }

      it "doesn't confirm the contact" do
        patch :update, params: { id: contact.to_param }
        expect(contact.reload.confirmed?).to be(false)
      end
    end

    context 'another user is signed in' do
      before(:each) { sign_in user }

      it "doesn't confirm the contact" do
        patch :update, params: { id: contact.to_param }
        expect(contact.reload.confirmed?).to be(false)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create :user }
    let(:sender) { create :user }
    let(:receiver) { create :user }
    let!(:contact) { create :contact, sender: sender, receiver: receiver }

    context "the contact's sender is signed in" do
      before(:each) { sign_in sender }

      it 'destroys the requested contact' do
        expect do
          delete :destroy, params: { id: contact.to_param }
        end.to change(Contact, :count).by(-1)
      end
    end

    context "the contact's receiver is signed in" do
      before(:each) { sign_in receiver }

      it 'destroys the requested contact' do
        expect {
          delete :destroy, params: { id: contact.to_param }
        }.to change(Contact, :count).by(-1)
      end
    end

    context 'another user is signed in' do
      before(:each) { sign_in user }

      it "doesn't destroy the requested contact" do
        expect {
          delete :destroy, params: { id: contact.to_param }
        }.to change(Contact, :count).by(0)
      end

      it 'redirects to the contacts list' do
        delete :destroy, params: { id: contact.to_param }
        expect(response).to redirect_to(contacts_url)
      end
    end
  end
end
