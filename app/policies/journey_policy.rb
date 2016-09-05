class JourneyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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

  def driver?
    record.user == user
  end

  def passenger?
    record.user == user
  end
end
