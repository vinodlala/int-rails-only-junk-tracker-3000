class MiniVan < ApplicationRecord
  has_one :base, class_name: 'Vehicle', as: :vehicle_type

  validates :doors, inclusion: { in: [ 0, 1, 2, 3, 4 ] }, allow_nil: true

  before_save do
    self.doors = 4 if doors.nil?
  end
end
