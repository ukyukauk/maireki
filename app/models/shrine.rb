# == Schema Information
#
# Table name: shrines
#
#  id         :bigint           not null, primary key
#  address    :string
#  blessings  :text
#  deities    :text
#  name       :string           not null
#  prefecture :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Shrine < ApplicationRecord
  has_many :visits, dependent: :destroy

  validates :name, presence: true
  validates :prefecture, presence: true
end
