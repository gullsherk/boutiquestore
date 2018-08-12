# lib/api/v1/root.rb
module API
  module V2
    class Root < Grape::API
      mount API::V1::Items
    end
  end
end