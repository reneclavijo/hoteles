# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_26_135729) do

  create_table "ciudades", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "habitaciones", force: :cascade do |t|
    t.string "nombre"
    t.boolean "esta_reservada"
    t.integer "precio"
    t.integer "hotel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_id"], name: "index_habitaciones_on_hotel_id"
  end

  create_table "hoteles", force: :cascade do |t|
    t.string "nombre"
    t.integer "estrellas"
    t.integer "ciudad_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ciudad_id"], name: "index_hoteles_on_ciudad_id"
  end

  create_table "reservas", force: :cascade do |t|
    t.integer "habitacion_id", null: false
    t.integer "usuario_id", null: false
    t.date "fecha_ingreso"
    t.date "fecha_salida"
    t.string "codigo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["habitacion_id"], name: "index_reservas_on_habitacion_id"
    t.index ["usuario_id"], name: "index_reservas_on_usuario_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "rol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.string "identificacion"
    t.string "telefono"
    t.string "password_digest"
    t.integer "rol_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rol_id"], name: "index_usuarios_on_rol_id"
  end

  add_foreign_key "habitaciones", "hoteles"
  add_foreign_key "hoteles", "ciudades"
  add_foreign_key "reservas", "habitaciones"
  add_foreign_key "reservas", "usuarios"
  add_foreign_key "usuarios", "roles"
end
