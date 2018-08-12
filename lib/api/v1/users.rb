# lib/api/v1/items.rb
module API
  module V1
    class Users < Grape::API
      version 'v1'
      format :json
 
      resource :users do
        # login a user into system
        desc "SignIn a user in system"
        params do
          requires :email,    type: String, desc: 'User email'
          requires :password, type: String, desc: 'User Password'
        end
        post '/signin' do
          @user = User.find_by_email(params[:email])
          error!({ error: 'User Does Not Exist! Please signup to continue!'}, 400) if @user.nil?

          if @user.password == params[:password]
            status 200
            @user
          else
            error!({ error: 'Incorrect Password, Please try again'}, 400)
          end
        end

        # Add a new user in system
        desc "Sign Up a new user in system"
        params do
          requires :email,      type: String, desc: 'User email'
          requires :password,   type: String, desc: 'User Password'
          requires :first_name, type: String, desc: 'User first name'
          requires :last_name,  type: String, desc: 'User last name'
          optional :phone,      type: String, desc: 'User phone'
        end
        post '/signup' do
          @user = User.new(
            email:      params[:email],
            password:   params[:password],
            first_name: params[:first_name],
            last_name:  params[:last_name],
            phone:      params[:phone]
          )

          if @user.save
            status 201
            @user
          else
            error!({ error: 'Invalid params', details: "#{@user.errors.full_messages.join(' ,')}" }, 400)
          end
        end
      end
    end
  end
end