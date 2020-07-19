FactoryBot.define do
  factory :thank do
    text {Faker::Lorem.sentence}
    sender {create(:user)}
    receiver {create(:user)}
  end
end