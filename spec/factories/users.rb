FactoryBot.define do
  factory :user do
    account { 'test_user' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
