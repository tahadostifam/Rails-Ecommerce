class UserPresenter
  # This method is defining a class method called `to_json` for the `UserPresenter` class. This
  # method takes a `user` object as an argument and returns a JSON representation of the user's attributes, excluding
  # certain attributes like "password", "password_digest", "created_at", and "updated_at".
  def self.to_json(user)
    user_attributes = user.attributes.except("password", "password_digest", "created_at", "updated_at")
    { user: user_attributes }
  end
end
