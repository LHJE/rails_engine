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

        def index
          render json: MerchantSerializer.new(Merchant.where("name like ?", "%#{params[:name]}%"))
        end

        def most_revenue

          # SELECT "invoice_items"."item_id", "status", "result", "merchant_id" , SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue
          # FROM "invoice_items"
          # INNER JOIN "invoices"
          # ON "invoices"."id" = "invoice_items"."invoice_id"
          # INNER JOIN "transactions"
          # ON "invoice_items"."invoice_id" = "transactions"."invoice_id"
          # ORDER BY revenue DESC
          # LIMIT 10;
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
      end
    end
  end
end
