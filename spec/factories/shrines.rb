FactoryBot.define do
  factory :shrine do
    name { "#{Faker::Lorem.word}神社" }
    prefecture { '兵庫県' }
  end
end
