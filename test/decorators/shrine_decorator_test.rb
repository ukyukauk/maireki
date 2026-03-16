# frozen_string_literal: true

require 'test_helper'

class ShrineDecoratorTest < ActiveSupport::TestCase
  def setup
    @shrine = Shrine.new.extend ShrineDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
