require 'faker'

FactoryGirl.define do

  factory :user do

    email { Faker::Internet.email }
    password '123456'
    password_confirmation '123456'

    trait :with_conversations do
      after :create do |user|
        FactoryGirl.create_list :conversation, 3, user_1: user
        FactoryGirl.create_list :conversation, 4, user_2: user
      end
    end
  end


  factory :conversation do
    user_1 { FactoryGirl.create :user }
    user_2 { FactoryGirl.create :user }
  end

  factory :message do
    conversation { FactoryGirl.create :conversation }
    user { FactoryGirl.create :user }
    body { Faker::Lorem.words 5 }
  end
end
