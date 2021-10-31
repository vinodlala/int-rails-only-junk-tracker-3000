class Vehicle < ApplicationRecord
  belongs_to :vehicle_type, polymorphic: true

  ENGINE_STATUSES = %w[
    works
    fixable
    junk
  ]

  validates :engine_status, inclusion: { in: ENGINE_STATUSES }, allow_blank: true

  validates :mileage, presence: true

  validates :wheels, inclusion: { in: [ 0, 1, 2, 3, 4 ] }, allow_nil: true
  validates :wheels, inclusion: { in: [ 0, 1, 2 ] }, allow_nil: true, if: :motorcycle?


  before_save do
    set_engine_status
    set_wheels
  end

  def motorcycle?
    vehicle_type.class == Motorcycle
  end

  def mileage_rating
    return if mileage.blank?
    return "low" if mileage < 10_000
    return "medium" if mileage < 100_000
    return "high"
  end

  def set_engine_status
    self.engine_status = "works" if engine_status.blank?
  end

  def set_wheels
    if wheels.blank?
      if motorcycle?
        self.wheels = 2
      else
        self.wheels = 4
      end
    end
  end
end
