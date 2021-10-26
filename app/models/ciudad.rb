class Ciudad < ApplicationRecord
    has_many :hoteles # una ciudad tiene muchos hoteles
end
