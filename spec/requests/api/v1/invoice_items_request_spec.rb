require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_items.count).to eq(3)

    invoice_items.each do |invoice_item|
      expect(invoice_item).to have_key(:id)
      expect(invoice_item[:id]).to be_an(Integer)

      expect(invoice_item).to have_key(:item_id)
      expect(invoice_item[:item_id]).to be_a(Integer)

      expect(invoice_item).to have_key(:invoice_id)
      expect(invoice_item[:invoice_id]).to be_a(Integer)

      expect(invoice_item).to have_key(:quantity)
      expect(invoice_item[:quantity]).to be_a(Integer)

      expect(invoice_item).to have_key(:unit_price)
      expect(invoice_item[:unit_price]).to be_a(Integer)
    end
  end


end
