require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices[:data].count).to eq(3)

    invoices[:data].each do |invoice|
      expect(invoice[:attributes]).to have_key(:id)
      expect(invoice[:attributes][:id]).to be_an(Integer)

      expect(invoice[:attributes]).to have_key(:customer_id)
      expect(invoice[:attributes][:customer_id]).to be_a(Integer)

      expect(invoice[:attributes]).to have_key(:merchant_id)
      expect(invoice[:attributes][:merchant_id]).to be_a(Integer)

      expect(invoice[:attributes]).to have_key(:status)
      expect(invoice[:attributes][:status]).to be_a(String)
    end
  end

  it "sends a list of invoices" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice[:data][:attributes]).to have_key(:id)
    expect(invoice[:data][:attributes][:id]).to be_an(Integer)

    expect(invoice[:data][:attributes]).to have_key(:customer_id)
    expect(invoice[:data][:attributes][:customer_id]).to be_a(Integer)

    expect(invoice[:data][:attributes]).to have_key(:merchant_id)
    expect(invoice[:data][:attributes][:merchant_id]).to be_a(Integer)

    expect(invoice[:data][:attributes]).to have_key(:status)
    expect(invoice[:data][:attributes][:status]).to be_a(String)
  end

  it "can create a new invoice" do
    invoice_params = ({
                    customer_id: 1,
                    merchant_id: 3,
                    status: "shipped"
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/invoices", headers: headers, params: JSON.generate(invoice: invoice_params)
    created_invoice = Invoice.last

    expect(response).to be_successful
    expect(created_invoice.customer_id).to eq(invoice_params[:customer_id])
    expect(created_invoice.merchant_id).to eq(invoice_params[:merchant_id])
    expect(created_invoice.status).to eq(invoice_params[:status])
  end

  it "can update an existing invoice" do
    id = create(:invoice).id
    previous_status = Invoice.last.status
    invoice_params = { status: "lost" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/invoices/#{id}", headers: headers, params: JSON.generate({invoice: invoice_params})
    invoice = Invoice.find_by(id: id)

    expect(response).to be_successful
    expect(invoice.status).to_not eq(previous_status)
    expect(invoice.status).to eq("lost")
  end

  it "can destroy an existing invoice" do
    invoice = create(:invoice)

    expect(Invoice.count).to eq(1)

    delete "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_successful
    expect(Invoice.count).to eq(0)
    expect{Invoice.find(invoice.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an existing invoice" do
    invoice = create(:invoice)

    expect{ delete "/api/v1/invoices/#{invoice.id}" }.to change(Invoice, :count).by(-1)

    expect(response).to be_success
    expect{Invoice.find(invoice.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can find a single record that matches an id" do
    create_list(:invoice, 3)
    get '/api/v1/invoices'

    attribute = "id"
    value = Invoice.first.id

    get "/api/v1/invoices/find?#{attribute}=#{value}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice[:data][:attributes]).to have_key(:id)
    expect(invoice[:data][:attributes][:id]).to eq(Invoice.first.id)

    expect(invoice[:data][:attributes]).to have_key(:customer_id)
    expect(invoice[:data][:attributes][:customer_id]).to eq(Invoice.first.customer_id)

    expect(invoice[:data][:attributes]).to have_key(:merchant_id)
    expect(invoice[:data][:attributes][:merchant_id]).to eq(Invoice.first.merchant_id)

    expect(invoice[:data][:attributes]).to have_key(:status)
    expect(invoice[:data][:attributes][:status]).to eq(Invoice.first.status)
  end

  it "can find a single record that matches an customer_id" do
    create_list(:invoice, 3)
    get '/api/v1/invoices'

    attribute = "customer_id"
    value = Invoice.first.customer_id

    get "/api/v1/invoices/find?#{attribute}=#{value}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice[:data][0][:attributes]).to have_key(:id)
    expect(invoice[:data][0][:attributes][:id]).to eq(Invoice.first.id)

    expect(invoice[:data][0][:attributes]).to have_key(:customer_id)
    expect(invoice[:data][0][:attributes][:customer_id]).to eq(Invoice.first.customer_id)

    expect(invoice[:data][0][:attributes]).to have_key(:merchant_id)
    expect(invoice[:data][0][:attributes][:merchant_id]).to eq(Invoice.first.merchant_id)

    expect(invoice[:data][0][:attributes]).to have_key(:status)
    expect(invoice[:data][0][:attributes][:status]).to eq(Invoice.first.status)
  end

  it "can find a single record that matches an merchant_id" do
    create_list(:invoice, 3)
    get '/api/v1/invoices'

    attribute = "merchant_id"
    value = Invoice.first.merchant_id

    get "/api/v1/invoices/find?#{attribute}=#{value}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice[:data][0][:attributes]).to have_key(:id)
    expect(invoice[:data][0][:attributes][:id]).to eq(Invoice.first.id)

    expect(invoice[:data][0][:attributes]).to have_key(:customer_id)
    expect(invoice[:data][0][:attributes][:customer_id]).to eq(Invoice.first.customer_id)

    expect(invoice[:data][0][:attributes]).to have_key(:merchant_id)
    expect(invoice[:data][0][:attributes][:merchant_id]).to eq(Invoice.first.merchant_id)

    expect(invoice[:data][0][:attributes]).to have_key(:status)
    expect(invoice[:data][0][:attributes][:status]).to eq(Invoice.first.status)
  end

  it "can find a single record that matches a status" do
    create_list(:invoice, 3)
    get '/api/v1/invoices'

    attribute = "status"
    value = Invoice.first.status

    get "/api/v1/invoices/find?#{attribute}=#{value}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice[:data][0][:attributes]).to have_key(:id)
    expect(invoice[:data][0][:attributes][:id]).to eq(Invoice.first.id)

    expect(invoice[:data][0][:attributes]).to have_key(:customer_id)
    expect(invoice[:data][0][:attributes][:customer_id]).to eq(Invoice.first.customer_id)

    expect(invoice[:data][0][:attributes]).to have_key(:merchant_id)
    expect(invoice[:data][0][:attributes][:merchant_id]).to eq(Invoice.first.merchant_id)

    expect(invoice[:data][0][:attributes]).to have_key(:status)
    expect(invoice[:data][0][:attributes][:status]).to eq(Invoice.first.status)
  end
end
