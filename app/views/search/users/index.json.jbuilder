if @users_vue
  json.array! @users_vue do |user|
    json.id user.id
    json.name user.name
    json.email user.email
    json.time user.created_at
    json.avatar user.avatar
  end
end