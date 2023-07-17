class Access
  ##
  # The above function initializes an object with an access hash, role, and controller name.
  #
  # Args:
  #   access_hash: The `access_hash` parameter is a hash that contains the access permissions for different roles in a
  # system. It is used to determine whether a user with a specific role has access to a specific controller or action.
  #   role: The `role` parameter is a symbol that represents the role of the user. It is used to determine the level of
  # access the user has in the system.
  #   controller_name: The `controller_name` parameter is the name of the controller that you want to initialize. It
  # should be a string representing the name of the controller.
  def initialize(access_hash, role, controller_name)
    @ctrl = controller_name.to_sym
    @role = role.to_sym
    @list = access_hash
  end

  ##
  # The function checks if a user with a specific role has access to perform a certain action.
  #
  # Args:
  #   action_name: The name of the action that you want to check access for. It should be a string or symbol.
  #   role_required: The `role_required` parameter is the role that is required to have access to a certain action. It can
  # be either `:admin` or `:seller`, where `:user` is the role of the current user.
  #
  # Returns:
  #   The method is returning a boolean value. It returns true if the conditions for access are met, and false otherwise.
  def has_access?(action_name, role_required)
    unless @list
      return false
    end

    if role_required == :admin || role_required == @role
      # Admin has access to do anything/
      if @role == :admin
        return true
      # This means that public actions deos not need to be limited by this class.
      elsif @role == :seller
        ctrl_list = @list[@ctrl]

        if ctrl_list && ctrl_list.length > 0
          if @list[@ctrl].include? action_name.to_sym
            return true
          end
        end
      end
    end

    return false
  end
end
