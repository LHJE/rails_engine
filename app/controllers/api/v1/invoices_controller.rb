module Api
  module V1
    class InvoicesController < ApplicationController
      def index
        render json: InvoiceSerializer.new(Invoice.all)
      end

      def show
        render json: InvoiceSerializer.new(Invoice.find(params[:id]))
      end

      def create
        render json: InvoiceSerializer.new(Invoice.create(invoice_params))
      end

      def update
        render json: InvoiceSerializer.new(Invoice.update(params[:id], invoice_params))
      end

      def destroy
        render json: Invoice.delete(params[:id])
      end

      private

      def invoice_params
        params.require(:invoice).permit(:customer_id, :merchant_id, :status)
      end
    end
  end
end
