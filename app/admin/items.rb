ActiveAdmin.register Item do

  permit_params :name, :type, :size, :price, :stock, :image

    form do |f|
    f.inputs do
      f.input :name
      f.input :type, as: :select, collection: Item::TYPES, include_blank: false
      f.input :size, as: :select, collection: Item::SIZES, include_blank: false
      f.input :price
      f.input :stock
      f.input :image
    end
    f.actions
  end

end
