module Api
  module V1
    module Customers
      class SearchController < ApplicationController
        def show
          if params.keys.include?("id")
            render json: CustomerSerializer.new(Customer.find(params[:id]))
          elsif params.keys.include?("first_name")
            render json: CustomerSerializer.new(Customer.where("first_name like ?", "%#{params[:first_name]}%"))
          else
            render json: CustomerSerializer.new(Customer.where(last_name: params[:last_name]))
          end
        end
      end
    end
  end
end
