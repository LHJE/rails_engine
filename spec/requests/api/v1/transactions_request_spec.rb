require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body, symbolize_names: true)

    expect(transactions.count).to eq(3)

    transactions.each do |transaction|
      expect(transaction).to have_key(:id)
      expect(transaction[:id]).to be_an(Integer)

      expect(transaction).to have_key(:result)
      expect(transaction[:result]).to be_a(String)

      expect(transaction).to have_key(:last_name)
      expect(transaction[:last_name]).to be_a(String)
    end
  end

  it "sends a list of transactions" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction).to have_key(:id)
    expect(transaction[:id]).to eq(id)

    expect(transaction).to have_key(:result)
    expect(transaction[:result]).to be_a(String)

    expect(transaction).to have_key(:last_name)
    expect(transaction[:last_name]).to be_a(String)
  end

  it "can create a new transaction" do
    transaction_params = ({
                    invoice_id: 2,
                    credit_card_number: 1234567890123456,
                    credit_card_expiration_date: "",
                    result: 'Jackie'
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/transactions", headers: headers, params: JSON.generate(transaction: transaction_params)
    created_transaction = Transaction.last

    expect(response).to be_successful
    expect(created_transaction.invoice_id).to eq(transaction_params[:invoice_id])
    expect(created_transaction.credit_card_number).to eq(transaction_params[:credit_card_number])
    expect(created_transaction.credit_card_expiration_date).to eq(transaction_params[:credit_card_expiration_date])
    expect(created_transaction.result).to eq(transaction_params[:result])
  end

  it "can update an existing transaction" do
    id = create(:transaction).id
    previous_result = Transaction.last.result
    transaction_params = { result: "failed" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/transactions/#{id}", headers: headers, params: JSON.generate({transaction: transaction_params})
    transaction = Transaction.find_by(id: id)

    expect(response).to be_successful
    expect(transaction.result).to_not eq(previous_result)
    expect(transaction.result).to eq("failed")
  end

  it "can destroy an existing transaction" do
    transaction = create(:transaction)

    expect(Transaction.count).to eq(1)

    delete "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_successful
    expect(Transaction.count).to eq(0)
    expect{Transaction.find(transaction.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an existing transaction" do
    transaction = create(:transaction)

    expect{ delete "/api/v1/transactions/#{transaction.id}" }.to change(Transaction, :count).by(-1)

    expect(response).to be_success
    expect{Transaction.find(transaction.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
