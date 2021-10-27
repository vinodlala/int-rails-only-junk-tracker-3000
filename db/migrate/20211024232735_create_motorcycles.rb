class CreateMotorcycles < ActiveRecord::Migration[6.1]
  def change
    create_table :motorcycles do |t|
      t.string :seat_status

      t.timestamps
    end
  end
end
