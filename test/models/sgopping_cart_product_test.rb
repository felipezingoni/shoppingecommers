# == Schema Information
#
# Table name: sgopping_cart_products
#
#  id               :bigint           not null, primary key
#  shopping_cart_id :bigint           not null
#  product_id       :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class SgoppingCartProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
