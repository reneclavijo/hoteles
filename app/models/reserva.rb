class Reserva < ApplicationRecord
    belongs_to :usuario     # una reserva le pertenece a un usuario
    belongs_to :habitacion  # una reserva le pertenece a una habitación
end
