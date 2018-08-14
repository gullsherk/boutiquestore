# lib/api/v1/orders.rb
module API
  module V1
    class Orders < Grape::API
      version 'v1'
      format :json
      formatter :json, Grape::Formatter::Rabl
 
      resource :orders do

        # list a particular order
        desc "list a particular order"
        get ':id', :rabl => "orders/show.rabl" do
          @order = Order.find_by_id(params[:id])
          error!({ error: 'Order not found' }, 404) if @order.nil?
        end

        # list all orders of a user
        desc "list all orders of a user"
        params do
          requires :user_id,    type: String, desc: 'User ID'
        end
        get :rabl => "orders/index.rabl" do
          user = User.find_by_id(params[:user_id])
          error!({ error: 'User not found' }, 404) if user.nil?
          
          @orders = user.orders
          
        end

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
        post :rabl => "orders/show.rabl" do
          order = Order.new(
            user_id: params[:user_id],
            comments: params[:comments],
            sub_total: params[:sub_total],
            order_items_attributes: params[:order_items_attributes]
          )

          if order.save
            status 201
            @order = Order.includes(:order_items).where(:id => order.id).first
          else
            error!({ error: 'Invalid params', details: "#{@order.errors.full_messages.join(' ,')}" }, 400)
          end
        end
      end
    end
  end
end