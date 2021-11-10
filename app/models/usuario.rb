class Usuario < ApplicationRecord
    has_secure_password

    belongs_to :rol # un usuario pertenece a un rol
    has_many :reservas # un usuario tiene muchas reservas
    has_many :habitaciones, through: :reservas # un usuario tiene muchas habitaciones a través de reservas

    validates :nombre,          presence: true
    validates :identificacion,  presence: true, uniqueness: true
    validates :telefono,        presence: true
    validates :rol_id,          presence: true
end
