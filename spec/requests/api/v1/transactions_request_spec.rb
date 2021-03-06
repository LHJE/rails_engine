# require 'rails_helper'
#
# RSpec.describe "Transactions API" do
#   it "sends a list of transactions" do
#     create_list(:transaction, 3)
#
#     get '/api/v1/transactions'
#
#     expect(response).to be_successful
#
#     transactions = JSON.parse(response.body, symbolize_names: true)
#
#     expect(transactions[:data].count).to eq(3)
#
#     transactions[:data].each do |transaction|
#       expect(transaction[:attributes]).to have_key(:id)
#       expect(transaction[:attributes][:id]).to be_an(Integer)
#
#       expect(transaction[:attributes]).to have_key(:credit_card_number)
#       expect(transaction[:attributes][:credit_card_number]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:credit_card_expiration_date)
#       expect(transaction[:attributes][:credit_card_expiration_date]).to eq(nil)
#
#       expect(transaction[:attributes]).to have_key(:result)
#       expect(transaction[:attributes][:result]).to be_a(String)
#     end
#   end
#
#   it "sends a list of transactions" do
#     id = create(:transaction).id
#
#     get "/api/v1/transactions/#{id}"
#
#     expect(response).to be_successful
#
#     transaction = JSON.parse(response.body, symbolize_names: true)
#
#     expect(transaction[:data][:attributes]).to have_key(:id)
#     expect(transaction[:data][:attributes][:id]).to eq(id)
#
#     expect(transaction[:data][:attributes]).to have_key(:credit_card_number)
#     expect(transaction[:data][:attributes][:credit_card_number]).to be_a(Integer)
#
#     expect(transaction[:data][:attributes]).to have_key(:credit_card_expiration_date)
#     expect(transaction[:data][:attributes][:credit_card_expiration_date]).to eq(nil)
#
#     expect(transaction[:data][:attributes]).to have_key(:result)
#     expect(transaction[:data][:attributes][:result]).to be_a(String)
#   end
#
#   it "can create a new transaction" do
#     transaction_params = ({
#                     invoice_id: 2,
#                     credit_card_number: 1234567890123456,
#                     credit_card_expiration_date: "",
#                     result: 'Jackie'
#                   })
#     headers = {"CONTENT_TYPE" => "application/json"}
#
#     post "/api/v1/transactions", headers: headers, params: JSON.generate(transaction: transaction_params)
#     created_transaction = Transaction.last
#
#     expect(response).to be_successful
#     expect(created_transaction.invoice_id).to eq(transaction_params[:invoice_id])
#     expect(created_transaction.credit_card_number).to eq(transaction_params[:credit_card_number])
#     expect("#{created_transaction.credit_card_expiration_date}").to eq(transaction_params[:credit_card_expiration_date])
#     expect(created_transaction.result).to eq(transaction_params[:result])
#   end
#
#   it "can update an existing transaction" do
#     id = create(:transaction).id
#     previous_result = Transaction.last.result
#     transaction_params = { result: "failed" }
#     headers = {"CONTENT_TYPE" => "application/json"}
#
#     patch "/api/v1/transactions/#{id}", headers: headers, params: JSON.generate({transaction: transaction_params})
#     transaction = Transaction.find_by(id: id)
#
#     expect(response).to be_successful
#     expect(transaction.result).to_not eq(previous_result)
#     expect(transaction.result).to eq("failed")
#   end
#
#   it "can destroy an existing transaction" do
#     transaction = create(:transaction)
#
#     expect(Transaction.count).to eq(1)
#
#     delete "/api/v1/transactions/#{transaction.id}"
#
#     expect(response).to be_successful
#     expect(Transaction.count).to eq(0)
#     expect{Transaction.find(transaction.id)}.to raise_error(ActiveRecord::RecordNotFound)
#   end
#
#   it "can destroy an existing transaction" do
#     transaction = create(:transaction)
#
#     expect{ delete "/api/v1/transactions/#{transaction.id}" }.to change(Transaction, :count).by(-1)
#
#     expect(response).to be_success
#     expect{Transaction.find(transaction.id)}.to raise_error(ActiveRecord::RecordNotFound)
#   end
#
#   it "can find a single record that matches an id" do
#     create_list(:transaction, 3)
#     get '/api/v1/transactions'
#
#     attribute = "id"
#     value = Transaction.first.id
#
#     get "/api/v1/transactions/find?#{attribute}=#{value}"
#     expect(response).to be_successful
#
#     transaction = JSON.parse(response.body, symbolize_names: true)
#
#     expect(transaction[:data][:attributes]).to have_key(:id)
#     expect(transaction[:data][:attributes][:id]).to eq(Transaction.first.id)
#
#     expect(transaction[:data][:attributes]).to have_key(:invoice_id)
#     expect(transaction[:data][:attributes][:invoice_id]).to eq(Transaction.first.invoice_id)
#
#     expect(transaction[:data][:attributes]).to have_key(:credit_card_number)
#     expect(transaction[:data][:attributes][:credit_card_number]).to eq(Transaction.first.credit_card_number)
#
#     expect(transaction[:data][:attributes]).to have_key(:result)
#     expect(transaction[:data][:attributes][:result]).to eq(Transaction.first.result)
#   end
#
#   it "can find a single record that matches an invoice_id" do
#     create_list(:transaction, 3)
#     get '/api/v1/transactions'
#
#     attribute = "invoice_id"
#     value = Transaction.first.invoice_id
#
#     get "/api/v1/transactions/find?#{attribute}=#{value}"
#     expect(response).to be_successful
#
#     transaction = JSON.parse(response.body, symbolize_names: true)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:id)
#     expect(transaction[:data][0][:attributes][:id]).to eq(Transaction.first.id)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:invoice_id)
#     expect(transaction[:data][0][:attributes][:invoice_id]).to eq(Transaction.first.invoice_id)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:credit_card_number)
#     expect(transaction[:data][0][:attributes][:credit_card_number]).to eq(Transaction.first.credit_card_number)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:result)
#     expect(transaction[:data][0][:attributes][:result]).to eq(Transaction.first.result)
#   end
#
#   it "can find a single record that matches an credit_card_number" do
#     create_list(:transaction, 3)
#     get '/api/v1/transactions'
#
#     attribute = "credit_card_number"
#     value = Transaction.first.credit_card_number
#
#     get "/api/v1/transactions/find?#{attribute}=#{value}"
#     expect(response).to be_successful
#
#     transaction = JSON.parse(response.body, symbolize_names: true)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:id)
#     expect(transaction[:data][0][:attributes][:id]).to eq(Transaction.first.id)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:invoice_id)
#     expect(transaction[:data][0][:attributes][:invoice_id]).to eq(Transaction.first.invoice_id)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:credit_card_number)
#     expect(transaction[:data][0][:attributes][:credit_card_number]).to eq(Transaction.first.credit_card_number)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:result)
#     expect(transaction[:data][0][:attributes][:result]).to eq(Transaction.first.result)
#   end
#
#   it "can find a single record that matches a result" do
#     create_list(:transaction, 3)
#     get '/api/v1/transactions'
#
#     attribute = "result"
#     value = Transaction.first.result
#
#     get "/api/v1/transactions/find?#{attribute}=#{value}"
#     expect(response).to be_successful
#
#     transaction = JSON.parse(response.body, symbolize_names: true)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:id)
#     expect(transaction[:data][0][:attributes][:id]).to eq(Transaction.first.id)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:invoice_id)
#     expect(transaction[:data][0][:attributes][:invoice_id]).to eq(Transaction.first.invoice_id)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:credit_card_number)
#     expect(transaction[:data][0][:attributes][:credit_card_number]).to eq(Transaction.first.credit_card_number)
#
#     expect(transaction[:data][0][:attributes]).to have_key(:result)
#     expect(transaction[:data][0][:attributes][:result]).to eq(Transaction.first.result)
#   end
#
#   it "can find a multiple records that match an invoice_id" do
#     create_list(:transaction, 3)
#     get '/api/v1/transactions'
#
#     attribute = "invoice_id"
#     value = Transaction.first.invoice_id
#
#     get "/api/v1/transactions/find_all?#{attribute}=#{value}"
#     expect(response).to be_successful
#
#     transactions = JSON.parse(response.body, symbolize_names: true)
#
#     transactions[:data].each do |transaction|
#       expect(transaction[:attributes]).to have_key(:id)
#       expect(transaction[:attributes][:id]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:invoice_id)
#       expect(transaction[:attributes][:invoice_id]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:credit_card_number)
#       expect(transaction[:attributes][:credit_card_number]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:result)
#       expect(transaction[:attributes][:result]).to be_a(String)
#     end
#   end
#
#   it "can find a multiple records that match an credit_card_number" do
#     create_list(:transaction, 3)
#     get '/api/v1/transactions'
#
#     attribute = "credit_card_number"
#     value = Transaction.first.credit_card_number
#
#     get "/api/v1/transactions/find_all?#{attribute}=#{value}"
#     expect(response).to be_successful
#
#     transactions = JSON.parse(response.body, symbolize_names: true)
#
#     transactions[:data].each do |transaction|
#       expect(transaction[:attributes]).to have_key(:id)
#       expect(transaction[:attributes][:id]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:invoice_id)
#       expect(transaction[:attributes][:invoice_id]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:credit_card_number)
#       expect(transaction[:attributes][:credit_card_number]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:result)
#       expect(transaction[:attributes][:result]).to be_a(String)
#     end
#   end
#
#   it "can find a multiple records that match a result" do
#     create_list(:transaction, 3)
#     get '/api/v1/transactions'
#
#     attribute = "result"
#     value = Transaction.first.result
#
#     get "/api/v1/transactions/find_all?#{attribute}=#{value}"
#     expect(response).to be_successful
#
#     transactions = JSON.parse(response.body, symbolize_names: true)
#
#     transactions[:data].each do |transaction|
#       expect(transaction[:attributes]).to have_key(:id)
#       expect(transaction[:attributes][:id]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:invoice_id)
#       expect(transaction[:attributes][:invoice_id]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:credit_card_number)
#       expect(transaction[:attributes][:credit_card_number]).to be_a(Integer)
#
#       expect(transaction[:attributes]).to have_key(:result)
#       expect(transaction[:attributes][:result]).to be_a(String)
#     end
#   end
# end
