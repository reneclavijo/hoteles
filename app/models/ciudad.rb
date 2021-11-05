class Ciudad < ApplicationRecord
    before_validation   :capitalizar_nombre
    after_validation    :despues_de_validar
    before_save         :antes_de_guardar
    after_save          :despues_de_guardar

    before_destroy      :antes_de_destuir
    after_destroy       :despues_de_destruir

    # has_many :hoteles, dependent: :destroy    # elimina todas los hoteles de una ciudad
    has_many :hoteles                           # una ciudad tiene muchos hoteles

    validates :nombre, presence: true
    validates :nombre, uniqueness: true

    private
    def capitalizar_nombre
        self.nombre = self.nombre.split(" ").map(&:capitalize).join(" ")
        puts "ANTES DE VALIDAR 🍕"
    end

    def despues_de_validar
        puts "DESPUES DE VALIDAR 🍔"
    end

    def antes_de_guardar
        puts "ANTES DE GUARDAR 🍟"
    end

    def despues_de_guardar
        puts "DESPUES DE GUARDAR 🌭"
    end

    def antes_de_destuir
        puts "ANTES DE DESTRUIR 🍿"
    end

    def despues_de_destruir
        puts "DESPUES DE DESTRUIR 🧂"
    end
end
