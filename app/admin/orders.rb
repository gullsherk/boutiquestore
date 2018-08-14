ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model

actions :index, :show
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  show do
    attributes_table do
      row :id
      row :user_id   
      row :date    
      row :comments  
      row :sub_total 
      row :tax       
      row :discount
      row :created_at
      row :updated_at
    end

    panel 'Order Items', only: :show do
      paginated_collection(order.order_items.order('created_at DESC').page(params[:page]).per(10), download_links: false) do
        table_for collection do
          column :id
          column :order
          column :item
          column :quantity
        end
      end
    end
  end

end
