FactoryBot.define do
  factory :group_user do
    association :user
    association :group
    rank {0}
    status {0}
    enrollment {true}
    request {false}
  end
end