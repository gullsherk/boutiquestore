ActiveAdmin.register Item do

  permit_params :name, :type, :size, :price, :stock, :image

end
