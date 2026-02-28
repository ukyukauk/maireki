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
#  user_id    :bigint           not null
#
# Indexes
#
#  index_shrines_on_user_id                          (user_id)
#  index_shrines_on_user_id_and_prefecture_and_name  (user_id,prefecture,name) UNIQUE
#
require 'test_helper'

class ShrineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
