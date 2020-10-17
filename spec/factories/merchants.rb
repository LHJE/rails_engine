FactoryBot.define do
  factory :merchant do
    name (Faker::IndustrySegments.sub_sector)
  end
end
