class CreateSedans < ActiveRecord::Migration[6.1]
  def change
    create_table :sedans do |t|
      t.integer :doors

      t.timestamps
    end
  end
end
