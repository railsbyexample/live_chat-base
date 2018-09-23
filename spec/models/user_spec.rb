require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    user = build :user
    expect(user).to be_valid
  end

  describe '#contacts' do
    it "returns all of a user's contacts" do
      user = create :user
      sent_contacts = create_list :contact, 3, sender: user
      received_contacts = create_list :contact, 3, receiver: user

      expect(user.contacts.to_a.sort).to eq((sent_contacts + received_contacts).sort)
    end
  end
end
