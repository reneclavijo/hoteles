class Ciudad < ApplicationRecord
    has_many :hoteles # una ciudad tiene muchos hoteles

    validates :nombre, presence: true
    validates :nombre, uniqueness: true
end
