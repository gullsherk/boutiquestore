# lib/api/v1/items.rb
module API
  module V1
    class Items < Grape::API
      version 'v1'
      format :json
 
      resource :items do
        # index endpoint to get all items 
        desc "Return list of all Items"
        get :rabl => "items/index.rabl" do
          @items = Item.all
        end

        # Show endpoint to a specific Item
        desc "Return a specific item"
        get ':id', :rabl => "items/show.rabl"  do
          @item = Item.find_by_id(params[:id])
        end
      end
    end
  end
end