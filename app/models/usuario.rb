class Usuario < ApplicationRecord
    belongs_to :rol # un usuario pertenece a un rol
    has_many :reservas # un usuario tiene muchas reservas
    has_many :habitaciones, through: :reservas # un usuario tiene muchas habitaciones a través de reservas
end
