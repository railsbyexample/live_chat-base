require 'rails_helper'

RSpec.describe Contact, type: :model do
  it 'has a valid factory' do
    contact = build :contact
    expect(contact).to be_valid
  end

  describe '#confirm' do
    it 'sets the confirmed_at timestamp and saves the user' do
      contact = build :contact
      contact.confirm
      expect(contact.confirmed_at).to be_within(2.seconds).of(Time.zone.now)
    end

    it 'returns false and does nothing if user is already confirmed' do
      confirmed_at = 2.days.ago
      contact = create :contact, confirmed_at: confirmed_at

      result = contact.confirm
      expect(result).to be(false)
      expect(contact.reload.confirmed_at).to eq(confirmed_at)
    end

    it 'returns false and does nothing if user is invalid' do
      contact = build :contact, sender: nil

      result = contact.confirm
      expect(result).to be(false)
      expect(contact.confirmed_at).to be_nil
    end
  end

  describe '.confirmed' do
    let(:contacts) { create_list :contact, 4 }
    before(:each) { contacts[0..1].each(&:confirm) }

    it 'returns only confirmed users' do
      expect(Contact.confirmed.to_a).to eq(contacts[0..1])
    end
  end

  describe '.unconfirmed' do
    let(:contacts) { create_list :contact, 4 }
    before(:each) { contacts[2..4].map(&:confirm) }

    it 'returns only confirmed users' do
      expect(Contact.unconfirmed.to_a).to eq(contacts[0..1])
    end
  end

  describe 'validations' do
    it 'is invalid without a sender' do
      contact = build :contact, sender: nil
      expect(contact).to be_invalid
    end

    it 'is invalid without a receiver' do
      contact = build :contact, receiver: nil
      expect(contact).to be_invalid
    end
  end
end
