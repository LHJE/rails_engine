# module Api
#   module V1
#     class CustomersController < ApplicationController
#       def index
#         render json: CustomerSerializer.new(Customer.all)
#       end
#
#       def show
#         render json: CustomerSerializer.new(Customer.find(params[:id]))
#       end
#
#       def create
#         render json: CustomerSerializer.new(Customer.create(customer_params))
#       end
#
#       def update
#         render json: CustomerSerializer.new(Customer.update(params[:id], customer_params))
#       end
#
#       def destroy
#         render json: Customer.delete(params[:id])
#       end
#
#       private
#
#       def customer_params
#         params.permit(:first_name, :last_name)
#       end
#     end
#   end
# end
