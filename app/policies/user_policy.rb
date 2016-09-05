class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    true
  end

  def update?
    record == user
  end

  def driver?
    record == user
  end

  def passenger?
    record == user
  end
end
