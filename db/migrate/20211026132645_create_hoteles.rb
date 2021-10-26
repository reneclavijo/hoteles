class CreateHoteles < ActiveRecord::Migration[6.1]
  def change
    create_table :hoteles do |t|
      t.string :nombre
      t.integer :estrellas
      t.references :ciudad, null: false, foreign_key: true

      t.timestamps
    end
  end
end
