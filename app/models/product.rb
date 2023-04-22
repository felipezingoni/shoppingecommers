# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  title      :string
#  code       :string
#  stock      :integer          default(0)
#  price      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord
  has_many :shopping_cart_products

  #Callbacks
  before_save :validate_product
  after_save :send_notification
  after_save :push_notification, if: :discount?

  #Validates
  validates :title, presence: {message: 'Es necesario que definas un valor para el titulo'}
  validates :code, presence: {message: 'Es necesario que definas un valor para el codigo'}
  validates :code, uniqueness: {message: 'El codigo: %{value} ya se encuentra en uso'}
  #validates :price, length: {minimum:3, maximum:10}
  validates :price, length: {in:3..10, message:"El precio se encuentra fuera del rango(Min:3, Max:10)"}
  validate :code_validate

  scope :available, -> {where('stock >= ?', 1)}
  scope :order_price_desc, -> {order('price DESC') }

  def self.top_5_available
    self.available.order_price_desc.limit(5).select(:title, :code)
  end

  def total
    self.price / 100
  end

  def discount?
    self.price < 5
  end

  private

  def code_validate
    if self.code.nil? || self.code.length < 3
      self.errors.add(:code, 'El codigo debe poseer por lo menos 3 caracteres.')
    end
  end

  def validate_product
    puts "\n\n\n>>> Un nuveo producto sera añadido a almacena!"
  end

  def send_notification
    puts "\n\n\n>>> Un Nuevo producto fue añadido a almacen:#{self.title} - $#{self.total} USD"
  end

  def push_notification
    puts "\n\n\n>>> Un nuevo producto en descuento ya se encuentra disponible: #{self.discount}"
  end
end
