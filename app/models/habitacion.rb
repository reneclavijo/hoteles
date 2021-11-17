class Habitacion < ApplicationRecord
    belongs_to :hotel   # una habitación le pertenece a un hotel
    has_many :reservas  # una habitación tiene muchas reservas
    has_many :usuarios, through: :reservas # una habitación tiene muchos usuarios a través de reservas

    has_many_attached :fotos
    
    validates :nombre, presence: true
    validates :precio, presence: true
    validates :hotel_id, presence: true
end
