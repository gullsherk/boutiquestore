ActiveAdmin.register Item do

  permit_params :name, :type, :size, :price, :stock

  index do
    selectable_column
    id_column
    column :name
    column :size
    column :type
    column :stock
    column :created_at
    actions
  end

end
