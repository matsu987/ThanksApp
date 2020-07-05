if @users_vue
  json.array! @users_vue do |user|
    json.id user.id
    json.family_name user.family_name
    json.given_name  user.given_name
    json.email user.email
    json.time user.created_at
    json.avatar user.avatar
  end
end