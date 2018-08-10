# == Schema Information
#
# Table name: order_items
#
#  id         :bigint(8)        not null, primary key
#  order_id   :integer
#  item_id    :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderItem < ApplicationRecord
  
  #Associations
  belongs_to :order
  belongs_to :item

  #Validations
  validates :quantity, presence: true
  validates_numericality_of :quantity, greater_than_or_equal_to: 1

end
