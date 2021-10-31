module VehicleType
  extend ActiveSupport::Concern

  included do
    has_one :vehicle, :as => :vehicle_type
  end
end
