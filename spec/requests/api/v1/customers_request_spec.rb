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
    expect(created_customer.title).to eq(customer_params[:first_name])
    expect(created_customer.author).to eq(customer_params[:last_name])
  end
end
