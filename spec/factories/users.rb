require 'faker'

FactoryBot.define do

  factory :user do

    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    confirmed_at { Time.now }

    trait :with_conversations do
      after :create do |user|
        FactoryBot.create_list :conversation, 3, user_1: user
        FactoryBot.create_list :conversation, 4, user_2: user
      end
    end
  end

  factory :conversation do
    user_1 { FactoryBot.create :user }
    user_2 { FactoryBot.create :user }
  end

  factory :message do
    conversation { FactoryBot.create :conversation }
    user { FactoryBot.create :user }
    body { Faker::Lorem.words 5 }
  end
end
