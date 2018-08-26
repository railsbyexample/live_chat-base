FactoryBot.define do
  factory :account do
    subdomain { Faker::Company.name.parameterize }
  end
end
