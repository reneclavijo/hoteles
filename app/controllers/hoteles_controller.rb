class HotelesController < ApplicationController

    # GET /hoteles
    def listar
        @hoteles = Hotel.all
    end

    # GET /hoteles/nuevo
    def nuevo
        @hotel = Hotel.new
        @ciudades = Ciudad.all
    end

    # POST /hoteles
    def guardar
        @hotel = Hotel.new(params_hotel)
        if @hotel.save
            # redirect_to hoteles_path # listar hoteles
        else
            @ciudades = Ciudad.all
            render :nuevo
        end
    end

    private
    def params_hotel
        return params.require(:hotel).permit(:nombre, :estrellas, :ciudad_id)
    end
    
end