class Rol < ApplicationRecord
    has_many :usuarios # tiene muchos usuarios

    before_validation :capitalizar_rol

    validates :rol, presence: true
    validates :rol, uniqueness: true

    private
    def capitalizar_rol
        self.rol = self.rol.split(" ").map(&:capitalize).join(" ")
    end
end
