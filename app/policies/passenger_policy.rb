class PassengerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def permitted_attributes
    if record.journey.user == user  # Driver
      [ :passenger_rating ]
    else
      [ :driver_rating ]
    end
  end

  def create?
    record.journey.user != user  # Driver cannot book his/her own journey.
  end

  def update?
    record.user == user  # Passenger can update his/her ride
  end

  def destroy?
    record.user == user # Passenger can cancel their booking
  end
end
