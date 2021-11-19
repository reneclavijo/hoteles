# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Habitacion.destroy_all
Hotel.destroy_all

# Creando los roles
Rol.create([
    {rol: 'Cliente'},
    {rol: 'Administrador'}
])
puts "Roles creados 💾"

Usuario.create([
    { nombre: 'admin', telefono: '999999', identificacion: 'admin', password: 'admin', rol: Rol.find_by(rol: 'Administrador') },
    { nombre: 'rene', telefono: '777777', identificacion: 'rene-001', password: 'qwerty', rol: Rol.find_by(rol: 'Cliente') }
])
puts "Usuarios creados 💾"

# Creando las ciudades
Ciudad.create([
    {nombre: 'Santiago'},
    {nombre: 'Bogotá'},
    {nombre: 'Quito'},
    {nombre: 'Caracas'},
    {nombre: 'Sucre'},
    {nombre: 'Buenos Aires'},
    {nombre: 'Montevideo'},
    {nombre: 'Asunsión'},
    {nombre: 'Lima'},
    {nombre: 'Brasilia'}
])
puts "Ciudades creadas 💾"

200.times do
    Hotel.create(
        { 
            nombre: Faker::Games::Pokemon.name, 
            estrellas: Faker::Number.between(from: 1, to: 5),
            ciudad: Ciudad.all.sample
        }
    )
end
puts "Hoteles creados 💾"

600.times do
    Habitacion.create({
        nombre:         Faker::Creature::Animal.name,
        esta_reservada: Faker::Boolean.boolean,
        precio:         Faker::Number.number(digits: 5),
        hotel:          Hotel.all.sample
    })
end
puts "Habitaciones creadas 💾"