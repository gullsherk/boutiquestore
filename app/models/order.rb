# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  date       :date
#  comments   :string
#  sub_total  :float
#  tax        :float
#  discount   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ApplicationRecord

  # Associations
  belongs_to :user
  has_many :order_items

  accepts_nested_attributes_for :order_items

  #Validations
  validates_numericality_of :sub_total, greater_than_or_equal_to: 1
  validates_numericality_of :discount, greater_than_or_equal_to: 1, less_than_or_equal_to: 100
  validates_numericality_of :tax, greater_than_or_equal_to: 1, less_than_or_equal_to: 100
  validates :comments, length: { maximum: 120 }

  before_validation :calculate_sum

  def calculate_sum
    self.tax ||= sub_total * 0.16
    self.discount ||= sub_total * 0.05
    self.date ||= Date.today
  end

end
