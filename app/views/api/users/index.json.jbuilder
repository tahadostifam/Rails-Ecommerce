json.msg msg

json.detail do
  json.user do
    json.name @user.name
    json.last_name @user.last_name
    json.username @user.username
    json.phone_number @user.phone_number
    json.role @user.role

    json.account_detail do
      json.address1 @user.account_detail.address1
      json.address2 @user.account_detail.address2
      json.postal_code @user.account_detail.postal_code
    end
  end
end
