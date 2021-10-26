class Habitacion < ApplicationRecord
    belongs_to :hotel   # una habitación le pertenece a un hotel
    has_many :reservas  # una habitación tiene muchas reservas
    has_many :usuarios, through: :reservas # una habitación tiene muchos usuarios a través de reservas
end
