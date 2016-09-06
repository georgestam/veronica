class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def update?
    record.user == user
    #  record - the car instance
    #  user - current_user
  end

  def destroy?
    record.user == user
  end
end
