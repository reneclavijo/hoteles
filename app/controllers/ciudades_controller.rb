class CiudadesController < ApplicationController

    def mostrar_formulario_crear
        @ciudad = Ciudad.new
    end
end