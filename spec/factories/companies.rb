FactoryBot.define do
  factory :company do
    name {Faker::Company.name}
    post_number {"123-1234"}
    address {"東京都世田谷区oooxxxx"}
    phone_number {"09012341234"}
  end
end