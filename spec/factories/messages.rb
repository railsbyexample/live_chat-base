FactoryBot.define do
  factory :message do
    contact { create :contact }
    user { create :user }
    body { Faker::Lorem.words 5 }
  end
end
