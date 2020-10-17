require 'rails_helper'

describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :status }
  end
end
