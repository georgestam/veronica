class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end
  
  def create?
    new?
  end
  
  def edit?
    update?
  end

  def update?
    record.user == user
    #  record - the car instance
    #  user - current_user
  end

  def destroy?
    record.user == user
  end

  def teacher?
    true
  end

end
