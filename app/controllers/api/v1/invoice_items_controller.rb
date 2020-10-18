module Api
  module V1
    class InvoiceItemsController < ApplicationController
      def index
        render json: InvoiceItem.all
      end

      def show
        render json: InvoiceItem.find(params[:id])
      end

      def create
        render json: InvoiceItem.create(invoice_item_params)
      end

      def update
        render json: InvoiceItem.update(params[:id], invoice_item_params)
      end

      def destroy
        render json: InvoiceItem.delete(params[:id])
      end

      private

      def invoice_item_params
        params.require(:invoice_item).permit(:item_id, :invoice_id, :quantity, :unit_price)
      end
    end
  end
end
