module Motor
  class Ability
    include CanCan::Ability

    def initialize(user)
      case user.role
      when 'admin'
        can :manage, :all
      when 'seller'
        resource_abilities
        motor_abilities
      end
    end

    def resource_abilities

    end

    def motor_abilities

    end
  end
end

