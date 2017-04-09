class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    create_or_destroy_or_checkout_or_charge?
  end
  
  def destroy?
    create_or_destroy_or_checkout_or_charge?
  end  
  
  def create_or_destroy_or_checkout_or_charge?
    record.journey.car == user.cars[0] || user.admin?
  end 
  
  def checkout?
    create_or_destroy_or_checkout_or_charge?
  end
  
  def charge?
    create_or_destroy_or_checkout_or_charge?
  end
  
end
