class Access
  def initialize(access_hash, role, controller_name)
    @ctrl = controller_name.to_sym
    @role = role.to_sym
    @list = access_hash
  end

  def has_access?(action_name, role_required)
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
