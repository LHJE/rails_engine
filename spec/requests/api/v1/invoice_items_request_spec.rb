require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_items[:data].count).to eq(3)

    invoice_items[:data].each do |invoice_item|
      expect(invoice_item[:attributes]).to have_key(:id)
      expect(invoice_item[:attributes][:id]).to be_an(Integer)

      expect(invoice_item[:attributes]).to have_key(:item_id)
      expect(invoice_item[:attributes][:item_id]).to be_a(Integer)

      expect(invoice_item[:attributes]).to have_key(:invoice_id)
      expect(invoice_item[:attributes][:invoice_id]).to be_a(Integer)

      expect(invoice_item[:attributes]).to have_key(:quantity)
      expect(invoice_item[:attributes][:quantity]).to be_a(Integer)

      expect(invoice_item[:attributes]).to have_key(:unit_price)
      expect(invoice_item[:attributes][:unit_price]).to be_a(Integer)
    end
  end

  it "sends a list of invoice_items" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item[:data][:attributes]).to have_key(:id)
    expect(invoice_item[:data][:attributes][:id]).to eq(id)

    expect(invoice_item[:data][:attributes]).to have_key(:item_id)
    expect(invoice_item[:data][:attributes][:item_id]).to be_a(Integer)

    expect(invoice_item[:data][:attributes]).to have_key(:invoice_id)
    expect(invoice_item[:data][:attributes][:invoice_id]).to be_a(Integer)

    expect(invoice_item[:data][:attributes]).to have_key(:quantity)
    expect(invoice_item[:data][:attributes][:quantity]).to be_a(Integer)

    expect(invoice_item[:data][:attributes]).to have_key(:unit_price)
    expect(invoice_item[:data][:attributes][:unit_price]).to be_a(Integer)
  end

  it "can create a new invoice_item" do
    invoice_item_params = ({
                        item_id: 1,
                        invoice_id: 1345134,
                        quantity: 12,
                        unit_price: 75107
                      })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/invoice_items", headers: headers, params: JSON.generate(invoice_item: invoice_item_params)
    created_invoice_item = InvoiceItem.last

    expect(response).to be_successful
    expect(created_invoice_item.item_id).to eq(invoice_item_params[:item_id])
    expect(created_invoice_item.invoice_id).to eq(invoice_item_params[:invoice_id])
    expect(response).to be_successful
    expect(created_invoice_item.quantity).to eq(invoice_item_params[:quantity])
    expect(created_invoice_item.unit_price).to eq(invoice_item_params[:unit_price])
  end

  it "can update an existing invoice_item" do
    id = create(:invoice_item).id
    previous_quantity = InvoiceItem.last.quantity
    invoice_item_params = { quantity: 567 }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/invoice_items/#{id}", headers: headers, params: JSON.generate({invoice_item: invoice_item_params})
    invoice_item = InvoiceItem.find_by(id: id)

    expect(response).to be_successful
    expect(invoice_item.quantity).to_not eq(previous_quantity)
    expect(invoice_item.quantity).to eq(567)
  end

  it "can destroy an existing invoice_item" do
    invoice_item = create(:invoice_item)

    expect(InvoiceItem.count).to eq(1)

    delete "/api/v1/invoice_items/#{invoice_item.id}"

    expect(response).to be_successful
    expect(InvoiceItem.count).to eq(0)
    expect{InvoiceItem.find(invoice_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an existing invoice_item" do
    invoice_item = create(:invoice_item)

    expect{ delete "/api/v1/invoice_items/#{invoice_item.id}" }.to change(InvoiceItem, :count).by(-1)

    expect(response).to be_success
    expect{InvoiceItem.find(invoice_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can find a single record that matches an id" do
    create_list(:invoice_item, 3)
    get '/api/v1/invoice_items'

    attribute = "id"
    value = InvoiceItem.first.id

    get "/api/v1/invoice_items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item[:data][:attributes]).to have_key(:id)
    expect(invoice_item[:data][:attributes][:id]).to eq(InvoiceItem.first.id)

    expect(invoice_item[:data][:attributes]).to have_key(:item_id)
    expect(invoice_item[:data][:attributes][:item_id]).to eq(InvoiceItem.first.item_id)

    expect(invoice_item[:data][:attributes]).to have_key(:invoice_id)
    expect(invoice_item[:data][:attributes][:invoice_id]).to eq(InvoiceItem.first.invoice_id)

    expect(invoice_item[:data][:attributes]).to have_key(:quantity)
    expect(invoice_item[:data][:attributes][:quantity]).to eq(InvoiceItem.first.quantity)

    expect(invoice_item[:data][:attributes]).to have_key(:unit_price)
    expect(invoice_item[:data][:attributes][:unit_price]).to eq(InvoiceItem.first.unit_price)
  end

  it "can find a single record that matches an item_id" do
    create_list(:invoice_item, 3)
    get '/api/v1/invoice_items'

    attribute = "item_id"
    value = InvoiceItem.first.item_id

    get "/api/v1/invoice_items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item[:data][0][:attributes]).to have_key(:id)
    expect(invoice_item[:data][0][:attributes][:id]).to eq(InvoiceItem.first.id)

    expect(invoice_item[:data][0][:attributes]).to have_key(:item_id)
    expect(invoice_item[:data][0][:attributes][:item_id]).to eq(InvoiceItem.first.item_id)

    expect(invoice_item[:data][0][:attributes]).to have_key(:invoice_id)
    expect(invoice_item[:data][0][:attributes][:invoice_id]).to eq(InvoiceItem.first.invoice_id)

    expect(invoice_item[:data][0][:attributes]).to have_key(:quantity)
    expect(invoice_item[:data][0][:attributes][:quantity]).to eq(InvoiceItem.first.quantity)

    expect(invoice_item[:data][0][:attributes]).to have_key(:unit_price)
    expect(invoice_item[:data][0][:attributes][:unit_price]).to eq(InvoiceItem.first.unit_price)
  end


end
