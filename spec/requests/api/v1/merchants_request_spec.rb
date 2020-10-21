require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_an(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "sends a list of merchants" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes]).to have_key(:id)
    expect(merchant[:data][:attributes][:id]).to eq(id)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "can create a new merchant" do
    merchant_params = ({
                    name: 'Persnickities',
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant: merchant_params)
    created_merchant = Merchant.last

    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Persnickities" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate({merchant: merchant_params})
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Persnickities")
  end

  it "can destroy an existing merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an existing merchant" do
    merchant = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_success
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can get the items specific to this merchant" do
    create_list(:item, 10)

    id = Merchant.first.id

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|
      expect(item[:attributes]).to have_key(:id)
      expect(item[:attributes][:id]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it "can find a single record that matches an id" do
    create_list(:merchant, 3)

    attribute = "id"
    value = Merchant.first.id

    get "/api/v1/merchants/find?#{attribute}=#{value}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes]).to have_key(:id)
    expect(merchant[:data][:attributes][:id]).to eq(Merchant.first.id)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to eq(Merchant.first.name)
  end

  it "can find a single record that matches a name" do
    create_list(:merchant, 3)

    attribute = "name"
    value = Merchant.first.name

    get "/api/v1/merchants/find?#{attribute}=#{value}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][0][:attributes]).to have_key(:id)
    expect(merchant[:data][0][:attributes][:id]).to eq(Merchant.first.id)

    expect(merchant[:data][0][:attributes]).to have_key(:name)
    expect(merchant[:data][0][:attributes][:name]).to eq(Merchant.first.name)
  end

  it "can find a single record that matches a partial name" do
    create_list(:merchant, 3)

    attribute = "last_name"
    value = Merchant.first.name[0..3]

    get "/api/v1/merchants/find?#{attribute}=#{value}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][0][:attributes]).to have_key(:id)
    expect(merchant[:data][0][:attributes][:id]).to eq(Merchant.first.id)

    expect(merchant[:data][0][:attributes]).to have_key(:name)
    expect(merchant[:data][0][:attributes][:name]).to eq(Merchant.first.name)
  end

  it "can find a multiple records that match a name" do
    create_list(:merchant, 3)

    attribute = "name"
    value = Merchant.first.name

    get "/api/v1/merchants/find_all?#{attribute}=#{value}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_a(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can find a multiple records that match a partial name" do
    create_list(:merchant, 3)

    attribute = "last_name"
    value = Merchant.first.name[0..3]

    get "/api/v1/merchants/find_all?#{attribute}=#{value}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_a(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can find a a variable number of merchants ranked by total revenue" do
    create_list(:transaction, 100)
    create_list(:invoice_item, 100)

    x = 5

    get "/api/v1/merchants/most_revenue?quantity=#{x}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_a(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end
