class CreateHabitaciones < ActiveRecord::Migration[6.1]
  def change
    create_table :habitaciones do |t|
      t.string :nombre
      t.boolean :esta_reservada
      t.integer :precio
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
