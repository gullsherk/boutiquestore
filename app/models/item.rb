# == Schema Information
#
# Table name: items
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  type       :string
#  size       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stock      :integer
#

class Item < ApplicationRecord
  self.inheritance_column = nil

  # Constants
  TYPES = ['T-Shirt', 'Shirts', 'Jeans', 'Hoodies', 'Jackets', 'Shorts', 'Trousers', 'Kurtas', 'Sweaters']
  SIZES = ['S', 'M', 'L', 'XL', 'XXL']

  # Associations
  has_many :order_items

  # Validations
  validates :name, presence: true, length: { maximum: 20 }
  validates :type, presence: true, inclusion: { :in => TYPES }, allow_blank: false
  validates :size, presence: true, inclusion: { :in => SIZES }, allow_blank: false
  validates :price, presence: true, uniqueness: true
  validates_numericality_of :price, greater_than_or_equal_to: 1
  validates_numericality_of :stock, greater_than_or_equal_to: 0

  mount_uploader :image, ImageUploader

  #Callbacks

  before_validation :set_default_type

  def set_default_type
  end

  #Methods
  

end
