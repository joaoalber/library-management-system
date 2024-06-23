FactoryBot.define do
  factory :borrowing do
    association :user, factory: :user
    association :book, factory: :book
  end
end