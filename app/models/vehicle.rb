class Vehicle < ApplicationRecord
  belongs_to :vehicle_type, polymorphic: true

  validates :mileage, presence: true

  validates :wheels, inclusion: { in: [ 0, 1, 2, 3, 4 ] }, allow_nil: true
  validates :wheels, inclusion: { in: [ 0, 1, 2 ] }, allow_nil: true, if: :motorcycle?

  def motorcycle?
    vehicle_type.class == Motorcycle
  end

  def mileage_rating
    return if mileage.blank?
    return "low" if mileage < 10_000
    return "medium" if mileage < 100_000
    return "high"
  end
end
