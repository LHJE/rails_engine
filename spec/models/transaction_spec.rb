require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :result }
  end

  describe 'Class Methods' do
    it "can load transactions" do
      Transaction.load_transactions('spec/fixtures/files/transactions_fixtures.csv')

      expect("#{Transaction.where(id: 1).class}").to eq("Transaction::ActiveRecord_Relation")
    end
  end
end
