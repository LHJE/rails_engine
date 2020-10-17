require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'Class Methods' do
    it "can load customers" do
      Customer.load_customers('spec/fixtures/files/customers_fixtures.csv')
      expect("#{Customer.where(id: 1).class}").to eq("Customer::ActiveRecord_Relation")
    end
  end
end
