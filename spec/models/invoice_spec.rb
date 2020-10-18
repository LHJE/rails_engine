require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :status }
  end

  # describe 'Class Methods' do
  #   it "can load invoices" do
  #     Customer.load_customers('spec/fixtures/files/customers_fixtures.csv')
  #     Merchant.load_merchants('spec/fixtures/files/merchants_fixtures.csv')
  #     Invoice.load_invoices('spec/fixtures/files/invoices_fixtures.csv')
  #
  #     expect("#{Invoice.where(id: 1).class}").to eq("Invoice::ActiveRecord_Relation")
  #   end
  # end
end
