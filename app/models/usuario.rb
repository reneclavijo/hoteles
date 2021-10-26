class Usuario < ApplicationRecord
  belongs_to :rol
  has_many :reservas
  has_many :habitaciones, through: :reservas
end
