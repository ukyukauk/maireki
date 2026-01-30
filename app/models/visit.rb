# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  impression :text
#  prayer     :text
#  visited_on :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  shrine_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_visits_on_shrine_id  (shrine_id)
#  index_visits_on_user_id    (user_id)
#
class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :shrine
  has_many :items, dependent: :destroy

  validates :visited_on, presence: true

  accepts_nested_attributes_for :items, # items_attributesをparamsに含める
    allow_destroy: true, # 編集画面でitemを削除可能にする
    reject_if: proc { |a| a['name'].blank? } # 空入力のitemを保存しない
end
