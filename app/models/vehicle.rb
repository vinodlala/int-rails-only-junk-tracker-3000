class Vehicle < ApplicationRecord
  belongs_to :vehicle_type, polymorphic: true

  validates :mileage, presence: true

  def mileage_rating
    return if mileage.blank?
    return "low" if mileage < 10_000
    return "medium" if mileage < 100_000
    return "high"
  end
end
