require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Contact. As you add validations to Contact, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Contact.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      contact = Contact.create! valid_attributes
      get :show, params: {id: contact.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      contact = Contact.create! valid_attributes
      get :edit, params: {id: contact.to_param}
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
        post :create, params: {contact: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        put :update, params: {id: contact.to_param, contact: new_attributes}
        contact.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the contact" do
        contact = Contact.create! valid_attributes
        put :update, params: {id: contact.to_param, contact: valid_attributes}
        expect(response).to redirect_to(contact)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        contact = Contact.create! valid_attributes
        put :update, params: {id: contact.to_param, contact: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, params: {id: contact.to_param}
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      contact = Contact.create! valid_attributes
      delete :destroy, params: {id: contact.to_param}
      expect(response).to redirect_to(contacts_url)
    end
  end

end
