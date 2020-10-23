module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def show
          if params.keys.include?("id")
            render json: MerchantSerializer.new(Merchant.find(params[:id]))
          else
            render json: MerchantSerializer.new(Merchant.where("name like ?", "%#{params[:name].downcase}%").first)
          end
        end

        def index
          render json: MerchantSerializer.new(Merchant.where("name like ?", "%#{params[:name]}%"))
        end

        def most_revenue
          merchant_ids = []
          invoices = Invoice.select("invoices.merchant_id, status, 'transactions.result', SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
                      .joins(:invoice_items, :transactions)
                      .where(transactions: {result: "success"})
                      .where(invoices: {status: "shipped"})
                      .order("revenue DESC")
                      .limit(params[:quantity])
                      # .pluck(:merchant_id)

          invoices.each do |invoice|
            merchant_ids << invoice[:merchant_id]
          end

          render json: MerchantSerializer.new(Merchant.where(id: merchant_ids))
        end

        # def most_items
        #
        #
        #   require "pry"; binding.pry
        #
        # end
      end
    end
  end
end
