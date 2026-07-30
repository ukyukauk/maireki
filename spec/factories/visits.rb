FactoryBot.define do
  factory :visit do
    visited_on { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    prayer { Faker::Lorem.sentence(word_count: 10) }
  end
end
