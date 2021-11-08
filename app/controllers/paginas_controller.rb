class PaginasController < ApplicationController

    layout 'layout_cliente' # Definiendo el layout a utilizar

    def principal
        @hoteles_encontrados = Hotel.all
        @ciudades_encontradas = Ciudad.all

        if params[:busqueda]
            # 1. Recuperando todos mis hoteles en la BD
            # @hoteles_encontrados = Hotel.all  
            # 2. Filtrarlos utilizando select
            @hoteles_encontrados = @hoteles_encontrados.select do |h|
                h.nombre.downcase.include? params[:busqueda].downcase
            end
            # Filtrado de ciudades
            @ciudades_encontradas = @ciudades_encontradas.select do |c|
                c.nombre.downcase.include? params[:busqueda].downcase
            end
        end

    end
    
    
    
end