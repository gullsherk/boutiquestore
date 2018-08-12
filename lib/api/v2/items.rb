# lib/api/v1/items.rb
module API
  module V1
    class Items < Grape::API
      version 'v1'
      format :json
 
      resource :items do

        desc "Return list of all Items"
        get do
          Item.all
        end

        get ':id' do
          Item.find_by_id(params[:id])
        end

        params do 
          requires :name, type:       :string
          requires :type, type:       :string
          requires :size, type:       :string
          requires :price, type:      :integer
          requires :stock, type:      :integer
        end
        post do
          @item = Item.new(
            name: params[:name]
            type: params[:type]
            size: params[:size]
            price: params[:price]
            stock: params[:stock]
          )

          if @item.save
            @item
            status 200
          else
            status 400
          end
        end

        delete ':id' do
          Item.find_by_id(params[:id]).destroy 
        end
    
      end
    end
  end
end