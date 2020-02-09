json.array! @users do |user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.time user.created_at
end