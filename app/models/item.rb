class Item < ApplicationRecord
  self.inheritance_column = nil
  has_many :order_items
  

end