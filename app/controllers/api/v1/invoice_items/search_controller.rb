module Api
  module V1
    module InvoiceItems
      class SearchController < ApplicationController
        def show
          if params.keys.include?("id")
            render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
          elsif params.keys.include?("item_id")
            render json: InvoiceItemSerializer.new(InvoiceItem.where("item_id like ?", "%#{params[:item_id]}%"))
          elsif params.keys.include?("invoice_id")
            render json: InvoiceItemSerializer.new(InvoiceItem.where("invoice_id like ?", "%#{params[:invoice_id]}%"))
          elsif params.keys.include?("quantity")
            render json: InvoiceItemSerializer.new(InvoiceItem.where("quantity like ?", "%#{params[:quantity]}%"))
          else
            render json: InvoiceItemSerializer.new(InvoiceItem.where("unit_price like ?", "%#{params[:unit_price]}%"))
          end
        end
      end
    end
  end
end
