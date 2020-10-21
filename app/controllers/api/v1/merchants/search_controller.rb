module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def show
          if params.keys.include?("id")
            render json: MerchantSerializer.new(Merchant.find(params[:id]))
          else
            render json: MerchantSerializer.new(Merchant.where("name like ?", "%#{params[:name]}%"))
          end
        end
      end
    end
  end
end
