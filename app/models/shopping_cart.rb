# == Schema Information
#
# Table name: shopping_carts
#
#  id         :bigint           not null, primary key
#  total      :integer          default(0)
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean          default(FALSE)
#
class ShoppingCart < ApplicationRecord
  has_many :shopping_cart_products
  belongs_to :user
  has_many :products, through: :shopping_cart_products

  def price
    self.total / 100
  end

  def update_total!
    self.update(total: self.get_total)
  end

  def get_total
    total = 0

    self.products.map do |product|
      total += product.price
    end

    total
  end
end
