class UserPresenter
  def self.to_json(user)
    user_attributes = user.attributes.except("password", "password_digest", "created_at", "updated_at")
    { user: user_attributes }
  end
end
