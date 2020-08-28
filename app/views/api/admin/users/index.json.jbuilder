json.array! @users do |user|
  json.user do
    json.id         user.id
    json.name       user.family_name + user.given_name
    json.email      user.email
    json.avatar     user.avatar
    json.status     user.group_users.last.status
    json.request    user.group_users.last.request
  end

  case user.groups.last.depth
  when 0 then
    json.company do
      json.id       user.groups.last.root.id
      json.name     user.groups.last.root.name
    end
    json.parent_group do
      json.id       "-"
      json.name     "-"
    end
    json.children_group do
      json.id       "-"
      json.name     "-"
    end
    json.grandchildren_group do
      json.id       "-"
      json.name     "-"
    end
  # 親部署しか登録していない時 
  when 1 then
    json.company do
      json.id       user.groups.last.root.id
      json.name     user.groups.last.root.name
    end
    json.parent_group do
      json.id       user.groups.last.id
      json.name     user.groups.last.name
    end
    json.children_group do
      json.id       "-"
      json.name     "-"
    end
    json.grandchildren_group do
      json.id       "-"
      json.name     "-"
    end
  # 子部署まで登録している時 
  when 2 then
    json.company do
      json.id       user.groups.last.root.id
      json.name     user.groups.last.root.name
    end
    json.parent_group do
      json.id       user.groups.last.parent.id
      json.name     user.groups.last.parent.name
    end
    json.children_group do
      json.id       user.groups.last.id
      json.name     user.groups.last.name
    end
    json.grandchildren_group do
      json.id       "-"
      json.name     "-"
    end
  # 孫部署まで登録している時 
  else
    json.company do
      json.id       user.groups.last.root.id
      json.name     user.groups.last.root.name
    end
    json.parent_group do
      json.id       user.groups.last.parent.parent.id
      json.name     user.groups.last.parent.parent.name
    end
    json.children_group do
      json.id       user.groups.last.parent.id
      json.name     user.groups.last.parent.name
    end
    json.grandchildren_group do
      json.id       user.groups.last.id
      json.name     user.groups.last.name
    end
  end
end