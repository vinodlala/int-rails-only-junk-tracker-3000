class Motorcycle < ApplicationRecord
  include VehicleType

  SEAT_STATUSES = %w[
    works
    fixable
    junk
  ]

  validates :seat_status, inclusion: { in: SEAT_STATUSES }, allow_blank: true

  before_save do
    self.seat_status = "works" if seat_status.blank?
  end
end
