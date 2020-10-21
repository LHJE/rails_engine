module Api
  module V1
    module Transactions
      class SearchController < ApplicationController
        def show
          if params.keys.include?("id")
            render json: TransactionSerializer.new(Transaction.find(params[:id]))
          elsif params.keys.include?("invoice_id")
            render json: TransactionSerializer.new(Transaction.where("invoice_id like ?", "%#{params[:invoice_id]}%"))
          elsif params.keys.include?("credit_card_number")
            render json: TransactionSerializer.new(Transaction.where("credit_card_number like ?", "%#{params[:credit_card_number]}%"))
          else
            render json: TransactionSerializer.new(Transaction.where("result like ?", "%#{params[:result]}%"))
          end
        end
      end
    end
  end
end
