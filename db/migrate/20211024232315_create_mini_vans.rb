class CreateMiniVans < ActiveRecord::Migration[6.1]
  def change
    create_table :mini_vans do |t|
      t.integer :doors

      t.timestamps
    end
  end
end
