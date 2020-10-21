# module Api
#   module V1
#     module Invoices
#       class SearchController < ApplicationController
#         def show
#           if params.keys.include?("id")
#             render json: InvoiceSerializer.new(Invoice.find(params[:id]))
#           elsif params.keys.include?("customer_id")
#             render json: InvoiceSerializer.new(Invoice.where("customer_id like ?", "%#{params[:customer_id]}%"))
#           elsif params.keys.include?("merchant_id")
#             render json: InvoiceSerializer.new(Invoice.where("merchant_id like ?", "%#{params[:merchant_id]}%"))
#           else
#             render json: InvoiceSerializer.new(Invoice.where("status like ?", "%#{params[:status]}%"))
#           end
#         end
#
#         def index
#           if params.keys.include?("customer_id")
#             render json: InvoiceSerializer.new(Invoice.where("customer_id like ?", "%#{params[:customer_id]}%"))
#           elsif params.keys.include?("merchant_id")
#             render json: InvoiceSerializer.new(Invoice.where("merchant_id like ?", "%#{params[:merchant_id]}%"))
#           else
#             render json: InvoiceSerializer.new(Invoice.where("status like ?", "%#{params[:status]}%"))
#           end
#         end
#       end
#     end
#   end
# end
