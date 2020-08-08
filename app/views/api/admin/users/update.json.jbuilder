if @error
  json.error do
    json.text        @error[:text]
    json.user_id      @error[:user_id] 
  end
else
  json.user do
    json.id         @user.id
    json.name       @user.family_name + @user.given_name
    json.email      @user.email
    json.avatar     @user.avatar
    json.status     @group_user.status
  end
end