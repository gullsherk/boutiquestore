# lib/api/v1/orders.rb
module API
  module V1
    class Orders < Grape::API
      version 'v1'
      format :json
 
      resource :orders do
        # creates an order in system
        desc "creates an order in system"
        params do
          requires :user_id,    type: String, desc: 'User ID'
          optional :comments, type: String, desc: 'User comments'
          requires :sub_total, type: String, desc: 'order Sub Total'
          group :order_items_attributes, type: Array do
            requires :item_id,     type: Integer
            requires :quantity,    type: Integer
          end
        end
        post do
          @order = Order.new(
            user_id: params[:user_id],
            comments: params[:comments],
            sub_total: params[:sub_total],
            order_items_attributes: params[:order_items_attributes]
          )

          if @order.save
            status 201
            @order
          else
            error!({ error: 'Invalid params', details: "#{@order.errors.full_messages.join(' ,')}" }, 400)
          end
        end
      end
    end
  end
end