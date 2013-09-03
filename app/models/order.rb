class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  attr_accessible :address, :email, :name, :pay_type
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
  validates :name, :address,:email, presence: true
  validates_format_of :email, allow_blank: true,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :pay_type, inclusion: PAYMENT_TYPES
  :name.IS_ALPHANUMERIC(error_message='must be alphanumeric!')
  def add_line_items_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart_id = nil
  		line_items << item
  	end
  end
end
