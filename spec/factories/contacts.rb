FactoryBot.define do
  factory :contact do
    sender { build :user }
    receiver { build :user }
    confirmed_at { nil }
  end
end
