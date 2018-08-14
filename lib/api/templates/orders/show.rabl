object @order => :order
attributes :id, :user_id,:date,:comments,:sub_total,:tax,:discount,:created_at,:updated_at

child :order_items => :order_items do
  attributes :id, :item_id, :quantity
end