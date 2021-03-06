class HotelesController < ApplicationController
    
    before_action :validar_sesion_administrador
    before_action :asignar_hotel, only: [:editar, :actualizar, :eliminar]

    # GET /hoteles
    def listar
        @hoteles = Hotel.includes(:ciudad)
    end

    # GET /hoteles/nuevo
    def nuevo
        @hotel = Hotel.new
        @ciudades = Ciudad.all
        @texto = "Crear hotel"

        if params[:id_ciudad]
            @hotel.ciudad_id = params[:id_ciudad]
        end
    end

    # GET /hoteles/:id/editar
    def editar
        @ciudades = Ciudad.all
        @texto = "Actualizar hotel"
    end

    # POST /hoteles
    def guardar
        @hotel = Hotel.new(params_hotel)
        if @hotel.save
            redirect_to hoteles_path # listar hoteles
        else
            @ciudades = Ciudad.all
            render :nuevo
        end
    end

    # PATCH /hoteles/:id
    def actualizar
        @hotel.nombre = params_hotel[:nombre]
        @hotel.estrellas = params_hotel[:estrellas]
        @hotel.ciudad_id = params_hotel[:ciudad_id]
        @hotel.foto_portada = params_hotel[:foto_portada]
        if @hotel.save
            redirect_to hoteles_path
        else
            @ciudades = Ciudad.all
            @texto = "Actualizar hotel desde actualizar"
            render :editar
        end
    end

    def eliminar
        @hotel.destroy
        redirect_to hoteles_path
    rescue
        flash[:error_hotel] = "No se puede eliminar el hotel #{@hotel.nombre}, porque tiene habitaciones registradas"
        redirect_to hoteles_path
    end

    private
    def params_hotel
        return params.require(:hotel).permit(:nombre, :estrellas, :ciudad_id, :foto_portada)
    end

    def asignar_hotel
        @hotel = Hotel.find_by(id: params[:id])
    end
    
end