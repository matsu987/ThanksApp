FactoryBot.define do
  factory :user do
    family_name  {Faker::Name.last_name}
    given_name {Faker::Name.first_name}
    sequence(:email) {Faker::Internet.email}
    password = Faker::Internet.password(min_length: 8)
    password {password}
    password_confirmation {password}
  end
end