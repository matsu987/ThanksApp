if @group_admin.present?
  json.id @group_admin.id
  json.name @group_admin.name
end

if @group.present?
  json.id @group.id
  json.name @group.name
end