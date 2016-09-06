class JourneyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(completed: false)
    end
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def driver_journey?
    record.user == user
  end
end
