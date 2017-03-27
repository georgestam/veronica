class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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

  def dashboard?
    record == user
  end

  def teacher?
    record == user
  end

end
