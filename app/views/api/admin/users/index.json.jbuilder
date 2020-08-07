json.array! @users do |user|
  json.user do
    json.id         user.id
    json.name       user.family_name + user.given_name
    json.email      user.email
    json.avatar     user.avatar
    json.status     user.group_users.first.status
  end
  case user.groups.length
  # 会社名しか登録していない時 
  when 1 then
    json.company do
      json.id       user.groups[0].id
      json.name     user.groups[0].name
    end

  # 親部署しか登録していない時 
  when 2 then
    json.company do
      json.id       user.groups[0].id
      json.name     user.groups[0].name
    end
    json.parent_group do
      json.id       user.groups[1].id
      json.name     user.groups[1].name
    end
  # 子部署まで登録している時 
  when 3 then
    json.company do
      json.id       user.groups[0].id
      json.name     user.groups[0].name
    end
    json.parent_group do
      json.id       user.groups[1].id
      json.name     user.groups[1].name
    end
    json.children_group do
      json.id       user.groups[2].id
      json.name     user.groups[2].name
    end
  # 孫部署まで登録している時 
  else
    json.company do
      json.id       user.groups[0].id
      json.name     user.groups[0].name
    end
    json.parent_group do
      json.id       user.groups[1].id
      json.name     user.groups[1].name
    end
    json.children_group do
      json.id       user.groups[2].id
      json.name     user.groups[2].name
    end
    json.grandchildren_group do
      json.id       user.groups[3].id
      json.name     user.groups[3].name
    end
  end
end