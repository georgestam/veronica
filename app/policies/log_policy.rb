class LogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def create?
    record.journey.car == user.cars[0] || user.admin?
  end
  
  def destroy?
    record.journey.car == user.cars[0] || user.admin?
  end  
end
