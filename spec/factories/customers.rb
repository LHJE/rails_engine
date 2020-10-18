FactoryBot.define do
  factory :customer do
    first_name { Faker::Games::Myst.character }
    last_name { Faker::Games::Pokemon.name }
  end
end
