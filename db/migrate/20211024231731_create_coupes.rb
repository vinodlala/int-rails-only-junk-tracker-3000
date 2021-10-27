class CreateCoupes < ActiveRecord::Migration[6.1]
  def change
    create_table :coupes do |t|
      t.integer :doors

      t.timestamps
    end
  end
end
