class Sedan < ApplicationRecord
  has_one :base, class_name: 'Vehicle', as: :vehicle_type
end
