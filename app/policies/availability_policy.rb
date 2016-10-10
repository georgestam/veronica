class AvailabilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    #  record - the car instance
    #  user - current_user
  end

  def destroy?
    true
  end
end
