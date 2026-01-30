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
require "test_helper"

class VisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
