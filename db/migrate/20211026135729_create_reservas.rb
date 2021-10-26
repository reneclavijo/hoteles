class CreateReservas < ActiveRecord::Migration[6.1]
  def change
    create_table :reservas do |t|
      t.references :habitacion, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true
      t.date :fecha_ingreso
      t.date :fecha_salida
      t.string :codigo

      t.timestamps
    end
  end
end
