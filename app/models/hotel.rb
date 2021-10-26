class Hotel < ApplicationRecord
  belongs_to :ciudad

  has_many :habitaciones
end
