require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  describe 'As an Admin' do
    before :each do
      Customer.load_customers('spec/fixtures/files/customers_fixtures.csv')
      Merchant.load_merchants('spec/fixtures/files/merchants_fixtures.csv')
      Item.load_items('spec/fixtures/files/items_fixtures.csv')
      Invoice.load_invoices('spec/fixtures/files/invoices_fixtures.csv')
      InvoiceItem.load_invoice_items('spec/fixtures/files/invoice_items_fixtures.csv')
      Transaction.load_transactions('spec/fixtures/files/transactions_fixtures.csv')
    end

    it "I can see things" do
      # require "pry"; binding.pry 
    end
  end
end
