FactoryBot.define do
  factory :group_user do
    group
    user
    rank {0}
    status {0}
    enrollment {true}
    request {false}
  end
end