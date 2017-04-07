class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    create_or_destroy?
  end
  
  def destroy?
    create_or_destroy?
  end  
  
  def create_or_destroy?
    record.journey.car == user.cars[0] || user.admin?
  end 
  
  def checkout?
    create_or_destroy?
  end
  
  def charge?
    create_or_destroy?
  end
  
end
