require 'rails_helper'

RSpec.describe Api do
  describe 'Class Methods' do
    it "can load a full json of all six features" do
      Api.load_json('spec/fixtures/files', 'customers_fixtures.csv', 'merchants_fixtures.csv', 'items_fixtures.csv', 'invoices_fixtures.csv', 'invoice_items_fixtures.csv', 'transactions_fixtures.csv')

      require "pry"; binding.pry
      expect("#{Api.where(id: 1).class}").to eq("API::ActiveRecord_Relation")
    end
  end
end
