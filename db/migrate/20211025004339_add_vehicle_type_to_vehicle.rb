class AddVehicleTypeToVehicle < ActiveRecord::Migration[6.1]
  def change
    add_reference :vehicles, :vehicle_type, polymorphic: true, null: false
  end
end
