# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  category   :integer          not null
#  name       :string           not null
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  visit_id   :bigint           not null
#
# Indexes
#
#  index_items_on_visit_id  (visit_id)
#
class Item < ApplicationRecord
  belongs_to :visit

  validates :name, presence: true
  validates :category, presence: true

  enum :category, {
    goshuin: 0,
    omamori: 1,
    omikuji: 2,
    ema: 3,
    other: 99
  }
end
