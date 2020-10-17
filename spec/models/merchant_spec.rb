require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe 'Class Methods' do
    it "can load merchants" do
      Merchant.load_merchants('spec/fixtures/files/merchants_fixtures.csv')

      expect("#{Merchant.where(id: 1).class}").to eq("Merchant::ActiveRecord_Relation")
    end
  end
end
