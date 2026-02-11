# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

yuka = User.create!(account: 'yuka', email: 'yuka@sample.com', password: '111111')
john = User.create!(account: 'john', email: 'john@sample.com', password: '111111')
emily = User.create!(account: 'emily', email: 'emily@sample.com', password: '111111')

yuka.shrines.create!(name: '大物主神社', prefecture: '兵庫県', address: '兵庫県尼崎市', deities: '大物主大神、市杵島姫命、田心姫命、湍津姫命', blessings: '五穀豊穣、農業漁業守護、交通安全、学業成就、厄除開運、勝運、縁結び、安産、病気平癒、芸事上達')
emily.shrines.create!(name: '姫嶋神社', prefecture: '大阪府')

users = [yuka, john, emily]

users.each do |user|
  user.shrines.create!(name: '伊勢神宮（外宮）', prefecture: '三重県')
  user.shrines.create!(name: '伊勢神宮（内宮）', prefecture: '三重県')

  shrines = user.shrines

  5.times do
    user.visits.create!(
      shrine: shrines.sample,
      visited_on: Faker::Date.between(from: 6.months.ago, to: Date.today),
      prayer: Faker::Lorem.sentence(word_count: 10),
      impression: Faker::Lorem.sentence(word_count: 20),
    )
  end
end
