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
require "test_helper"

class ShrineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
