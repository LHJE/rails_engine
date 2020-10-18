require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  # describe 'Class Methods' do
  #   it "can load items" do
  #     Merchant.load_merchants('spec/fixtures/files/merchants_fixtures.csv')
  #
  #     Item.load_items('spec/fixtures/files/items_fixtures.csv')
  #
  #     expect("#{Item.where(id: 1).class}").to eq("Item::ActiveRecord_Relation")
  #   end
  # end
end
