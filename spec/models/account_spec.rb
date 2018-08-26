require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'has a valid factory' do
    account = build :account
    expect(account).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a subdomain' do
      account = build :account, subdomain: ''
      expect(account).to be_invalid
    end

    it 'is invalid with an existing subdomain' do
      existing_subdomain = 'existing-already'
      create :account, subdomain: existing_subdomain

      account = build :account, subdomain: existing_subdomain

      expect(account).to be_invalid
    end

    it 'is invalid with a non url_safe subdomain' do
      non_url_safe_subdomain = '--notsafe'
      account = build :account, subdomain: non_url_safe_subdomain

      expect(account).to be_invalid
    end
  end
end
