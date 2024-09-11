json.user do
  json.name @user.name
  json.email @user.email
  json.location @user.location
  json.city @user.city
  json.updatedAt @user.updated_at
end
