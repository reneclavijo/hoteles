class PaginasController < ApplicationController

    layout 'layout_cliente' # Definiendo el layout a utilizar
    before_action :validar_sesion_sin_redirigir

    def principal

        @hoteles_encontrados = Hotel.includes(:ciudad).shuffle
        @ciudades_encontradas = Ciudad.includes(:hoteles)

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

    # GET /paginas/:id_hotel
    def info_hotel
        # recuperar el :id_hotel que llega desde los params
        id = params[:id_hotel]
        # buscar el hotel utilizando el modelo Hotel
        @hotel_encontrado = Hotel.find(id) # el método find() busca por el id de una tabla
    # controlar si el ID no existe
    rescue
        redirect_to root_path
    end

end