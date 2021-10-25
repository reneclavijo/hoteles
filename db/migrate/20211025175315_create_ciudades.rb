class CreateCiudades < ActiveRecord::Migration[6.1]
  def change
    create_table :ciudades do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
