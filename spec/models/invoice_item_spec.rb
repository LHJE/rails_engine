require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end

  describe 'Class Methods' do
    it "can load invoice_items" do
      Customer.load_customers('spec/fixtures/files/customers_fixtures.csv')
      Merchant.load_merchants('spec/fixtures/files/merchants_fixtures.csv')
      Item.load_items('spec/fixtures/files/items_fixtures.csv')
      Invoice.load_invoices('spec/fixtures/files/invoices_fixtures.csv')

      InvoiceItem.load_invoice_items('spec/fixtures/files/invoice_items_fixtures.csv')
      
      expect("#{InvoiceItem.where(id: 1).class}").to eq("InvoiceItem::ActiveRecord_Relation")
    end
  end
end
