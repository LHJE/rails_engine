require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers.count).to eq(3)

    customers.each do |customer|
      expect(customer).to have_key(:id)
      expect(customer[:id]).to be_an(Integer)

      expect(customer).to have_key(:first_name)
      expect(customer[:first_name]).to be_a(String)

      expect(customer).to have_key(:last_name)
      expect(customer[:last_name]).to be_a(String)
    end
  end

  it "sends a list of customers" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(customer).to have_key(:id)
    expect(customer[:id]).to eq(id)

    expect(customer).to have_key(:first_name)
    expect(customer[:first_name]).to be_a(String)

    expect(customer).to have_key(:last_name)
    expect(customer[:last_name]).to be_a(String)
  end

  it "can create a new customer" do
    customer_params = ({
                    first_name: 'Jackie',
                    last_name: 'Chan'
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/customers", headers: headers, params: JSON.generate(customer: customer_params)
    created_customer = Customer.last

    expect(response).to be_successful
    expect(created_customer.first_name).to eq(customer_params[:first_name])
    expect(created_customer.last_name).to eq(customer_params[:last_name])
  end

  it "can update an existing customer" do
    id = create(:customer).id
    previous_name = Customer.last.first_name
    customer_params = { first_name: "Georgeous" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/customers/#{id}", headers: headers, params: JSON.generate({customer: customer_params})
    customer = Customer.find_by(id: id)

    expect(response).to be_successful
    expect(customer.first_name).to_not eq(previous_name)
    expect(customer.first_name).to eq("Georgeous")
  end

  it "can destroy an existing customer" do
    customer = create(:customer)

    expect(Customer.count).to eq(1)

    delete "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful
    expect(Customer.count).to eq(0)
    expect{Customer.find(customer.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can destroy an existing customer" do
    customer = create(:customer)

    expect{ delete "/api/v1/customers/#{customer.id}" }.to change(Customer, :count).by(-1)

    expect(response).to be_success
    expect{Customer.find(customer.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
