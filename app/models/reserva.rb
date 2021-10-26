class Reserva < ApplicationRecord
  belongs_to :habitacion
  belongs_to :usuario
end
