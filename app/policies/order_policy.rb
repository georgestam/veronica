class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    true
  end
  
  def create?
    create_or_destroy?
  end
  
  def destroy?
    create_or_destroy?
  end  
  
  def create_or_destroy?
    record.journey.car == user.cars.first || user.admin?
  end 
  
  def checkout?
    checkout_or_charge?
  end
  
  def charge?
    checkout_or_charge?
  end
  
  def checkout_or_charge?
    record.journey.user == user
  end 
  
end
