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
    true
  end

  def destroy?
    true
  end
end
