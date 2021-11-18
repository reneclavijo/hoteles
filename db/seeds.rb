# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Hotel.destroy_all

# Creando los roles
Rol.create([
    {rol: 'Cliente'},
    {rol: 'Administrador'}
])
puts "Roles creados 💾"

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