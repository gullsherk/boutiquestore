ActiveAdmin.register Item do
  index do
    selectable_column
    id_column
    column :name
    column :size
    column :type
    column :created_at
    actions
  end

end
