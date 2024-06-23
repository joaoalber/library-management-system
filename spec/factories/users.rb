FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    role { "member" }
    password { SecureRandom.alphanumeric }
  end
end
