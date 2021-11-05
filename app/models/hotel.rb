class Hotel < ApplicationRecord
    has_many :habitaciones  # un hotel tiene muchas habitaciones
    belongs_to :ciudad      # un hotel le pertenece a una ciudad

    before_validation :capitalizar_nombre

    validates :nombre,      presence: true
    validates :estrellas,   presence: true
    validates :ciudad_id,   presence: true

    private
    def capitalizar_nombre
        self.nombre = self.nombre.split(" ").map(&:capitalize).join(" ")
    end
end