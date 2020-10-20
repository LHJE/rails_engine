module Api
  module V1
    class InvoiceItemsController < ApplicationController
      def index
        render json: InvoiceItemSerializer.new(InvoiceItem.all)
      end

      def show
        render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
      end

      def create
        render json: InvoiceItemSerializer.new(InvoiceItem.create(invoice_item_params))
      end

      def update
        render json: InvoiceItemSerializer.new(InvoiceItem.update(params[:id], invoice_item_params))
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
