FactoryBot.define do
  factory :group do
    name {Faker::Company.name}
    company

    trait :have_parent do
      after(:create) do | group |
        group.children.create(name: "sample", company_id: group.company.id)
      end
    end
    
    trait :have_child do
      after(:create) do | group |
        parent_group = group.children.create(name: "親部署", company_id: group.company.id)
        children_group = parent_group.children.create(name: "子部署", company_id: group.company.id)
      end
    end

    trait :have_grand_child do
      after(:create) do | group |
        parent_group = group.children.create(name: "親部署", company_id: group.company.id)
        children_group = parent_group.children.create(name: "子部署", company_id: group.company.id)
        grand_children_group = children_group.children.create(name: "孫部署", company_id: group.company.id)
      end
    end
  end
end