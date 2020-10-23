module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def show
          if params.keys.include?("id")
            render json: ItemSerializer.new(Item.find(params[:id]))
          elsif params.keys.include?("name")
            render json: ItemSerializer.new(Item.where("name like ?", "%#{params[:name].downcase}%").first)
          elsif params.keys.include?("description")
            render json: ItemSerializer.new(Item.where("description like ?", "%#{params[:description].downcase}%").first)
          elsif params.keys.include?("unit_price")
            render json: ItemSerializer.new(Item.where("unit_price like ?", "%#{params[:unit_price]}%").first)
          else
            render json: ItemSerializer.new(Item.where("merchant_id like ?", "%#{params[:merchant_id]}%").first)
          end
        end

        def index
          if params.keys.include?("name")
            render json: ItemSerializer.new(Item.where("name like ?", "%#{params[:name]}%"))
          elsif params.keys.include?("description")
            render json: ItemSerializer.new(Item.where("description like ?", "%#{params[:description]}%"))
          elsif params.keys.include?("unit_price")
            render json: ItemSerializer.new(Item.where("unit_price like ?", "%#{params[:unit_price]}%"))
          else
            render json: ItemSerializer.new(Item.where("merchant_id like ?", "%#{params[:merchant_id]}%"))
          end
        end
      end
    end
  end
end
