require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

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

  it "sends a list of items" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes]).to have_key(:id)
    expect(item[:data][:attributes][:id]).to eq(id)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it "can create a new item" do
    item_params = ({
                    name: 'Socks',
                    description: 'Great socks',
                    unit_price: 234,
                    merchant_id: 1
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Socks" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Socks")
  end

  it "can destroy an existing item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an existing item" do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_success
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can get merchant specific to the item " do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    id = create(:item).id

    get "/api/v1/items/#{id}/merchants"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes]).to have_key(:id)
    expect(merchant[:data][:attributes][:id]).to eq(id)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "can find a single record that matches an id" do
    create_list(:item, 3)
    get '/api/v1/items'

    attribute = "id"
    value = Item.first.id

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes]).to have_key(:id)
    expect(item[:data][:attributes][:id]).to eq(Item.first.id)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to eq(Item.first.name)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to eq(Item.first.description)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to eq(Item.first.unit_price)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to eq(Item.first.merchant_id)
  end

  it "can find a single record that matches an name" do
    create_list(:item, 3)
    get '/api/v1/items'

    attribute = "name"
    value = Item.first.name

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][0][:attributes]).to have_key(:id)
    expect(item[:data][0][:attributes][:id]).to eq(Item.first.id)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes][:name]).to eq(Item.first.name)

    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes][:description]).to eq(Item.first.description)

    expect(item[:data][0][:attributes]).to have_key(:unit_price)
    expect(item[:data][0][:attributes][:unit_price]).to eq(Item.first.unit_price)

    expect(item[:data][0][:attributes]).to have_key(:merchant_id)
    expect(item[:data][0][:attributes][:merchant_id]).to eq(Item.first.merchant_id)
  end

  it "can find a single record that matches an name" do
    create_list(:item, 3)
    get '/api/v1/items'

    attribute = "name"
    value = Item.first.name[0..3]

    get "/api/v1/items/find?#{attribute}=#{value}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][0][:attributes]).to have_key(:id)
    expect(item[:data][0][:attributes][:id]).to eq(Item.first.id)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes][:name]).to eq(Item.first.name)

    expect(item[:data][0][:attributes]).to have_key(:description)
    expect(item[:data][0][:attributes][:description]).to eq(Item.first.description)

    expect(item[:data][0][:attributes]).to have_key(:unit_price)
    expect(item[:data][0][:attributes][:unit_price]).to eq(Item.first.unit_price)

    expect(item[:data][0][:attributes]).to have_key(:merchant_id)
    expect(item[:data][0][:attributes][:merchant_id]).to eq(Item.first.merchant_id)
  end

end
