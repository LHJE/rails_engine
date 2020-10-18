module Api
  module V1
    class TransactionsController < ApplicationController
      def index
        render json: Transaction.all
      end

      def show
        render json: Transaction.find(params[:id])
      end

      def create
        render json: Transaction.create(transaction_params)
      end

      def update
        render json: Transaction.update(params[:id], transaction_params)
      end

      def destroy
        render json: Transaction.delete(params[:id])
      end

      private

      def transaction_params
        params.require(:transaction).permit(:invoice_id, :credit_card_number, :credit_card_expiration_date, :result)
      end
    end
  end
end
