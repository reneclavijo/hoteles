class Rol < ApplicationRecord
    has_many :usuarios # tiene muchos usuarios

    validates :rol, presence: true
    validates :rol, uniqueness: true
end
