FactoryBot.define do
  factory :group do
    name {Faker::Company.name}
    company
  end
end