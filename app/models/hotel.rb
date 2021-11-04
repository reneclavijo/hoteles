class Hotel < ApplicationRecord
    has_many :habitaciones  # un hotel tiene muchas habitaciones
    belongs_to :ciudad      # un hotel le pertenece a una ciudad

    validates :nombre,      presence: true
    validates :estrellas,   presence: true
    validates :ciudad_id,   presence: true
end