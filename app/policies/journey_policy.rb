class JourneyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    create?
  end
  
  def create?
    true
  end

  def update?
    record.user == user || record.car == user.cars[0]
  end

  def destroy?
    record.user == user || record.car == user.cars[0]

  end

  def driver_journey?
    record.user == user
  end

  def journey_information?
    true
  end

  def teacher?
    true
  end
end
