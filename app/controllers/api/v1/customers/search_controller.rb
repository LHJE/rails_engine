class Api::V1::Customers::SearchController < ApplicationController
  def show
    if params.keys.include?("id")
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    elsif params.keys.include?("first_name")
      require "pry"; binding.pry
    else
      require "pry"; binding.pry
    end
  end
end
