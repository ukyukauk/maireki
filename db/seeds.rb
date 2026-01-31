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

users = [yuka, john, emily]

Shrine.create!(name: '大物主神社', prefecture: '兵庫県')
Shrine.create!(name: '尼崎えびす神社', prefecture: '兵庫県')
Shrine.create!(name: '姫嶋神社', prefecture: '大阪府')
Shrine.create!(name: 'サムハラ神社', prefecture: '大阪府')
Shrine.create!(name: '伊勢神宮（内宮）', prefecture: '三重県')
Shrine.create!(name: '伊勢神宮（外宮）', prefecture: '三重県')

shrines = Shrine.all

users.each do |user|
    5.times do
      user.visits.create!(
        shrine: shrines.sample,
        visited_on: Faker::Date.between(from: 6.months.ago, to: Date.today),
        prayer: Faker::Lorem.sentence(word_count: 10),
        impression: Faker::Lorem.sentence(word_count: 20),
      )
    end
end
