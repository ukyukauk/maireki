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
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
