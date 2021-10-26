class CreateUsuarios < ActiveRecord::Migration[6.1]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :identificacion
      t.string :telefono
      t.string :password_digest
      t.references :rol, null: false, foreign_key: true

      t.timestamps
    end
  end
end
