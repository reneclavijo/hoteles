class Reserva < ApplicationRecord
    belongs_to :usuario     # una reserva le pertenece a un usuario
    belongs_to :habitacion  # una reserva le pertenece a una habitación

    validates :fecha_ingreso, presence: true
    validates :fecha_salida, presence: true
end
