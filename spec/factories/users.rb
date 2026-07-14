FactoryBot.define do
  factory :user do
    sequence(:account) { |n| "test_user_#{n}" }
    sequence(:email) { |n| "test_user_#{n}@example.com" }
    password { 'password' }
  end
end
