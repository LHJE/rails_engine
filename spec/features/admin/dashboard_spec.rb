require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As an Admin' do
    before :each do
      @customer_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
      @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
      @item_1 = Item.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: "75107", merchant_id: @merchant_1.id)
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant_1.id, status: "shipped")
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: "13635")
      @transaction_1 = Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: "4654405418249632", credit_card_expiration_date: " ", result: "success")
    end

    it "I can see things" do
      # csv_table = CSV.parse(File.read('db/data/customers.csv'), headers: true)
      # json_string = csv_table.map(&:to_h).to_json
      customers = []
      CSV.foreach('db/data/customers.csv', headers: true, header_converters: :symbol) do |data|
        customers << Customer.new(data.to_h)
      end
      require "pry"; binding.pry
    end
  end
end
