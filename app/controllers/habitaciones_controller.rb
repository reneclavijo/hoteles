class HabitacionesController < ApplicationController
    
    before_action :asignar_habitacion, only: [:mostrar, :editar, :actualizar, :eliminar]
    
    # GET /habitaciones
    def listar
        @habitaciones = Habitacion.all
    end

    # GET /habitaciones/nueva
    def nueva
        @habitacion = Habitacion.new
        @hoteles = Hotel.all
        @texto_boton = "Registrar habitación"
    end

    # GET /habitaciones/:id
    def mostrar
    end

    # GET /habitaciones/:id/editar
    def editar
        @hoteles = Hotel.all
        @texto_boton = "Actualizar habitación"
    end

    # POST /habitaciones
    def guardar
        @habitacion = Habitacion.new(params_habitacion)
        if @habitacion.save
            redirect_to habitaciones_path
        else
            @hoteles = Hotel.all
            @texto_boton = "Registrar habitación"
            render :nueva
        end
    end

    # PATH/PUT /habitaciones/:id
    def actualizar
        @habitacion.nombre          = params_habitacion[:nombre]
        @habitacion.esta_reservada  = params_habitacion[:esta_reservada]
        @habitacion.precio          = params_habitacion[:precio]
        @habitacion.hotel_id        = params_habitacion[:hotel_id]
        if @habitacion.save
            redirect_to habitaciones_path
        else
            @hoteles = Hotel.all
            @texto_boton = "Actualizar habitación"
            render :editar
        end
    end

    # DELETE /habitaciones/:id
    def eliminar
        @habitacion.destroy
        redirect_to habitaciones_path
    end

    private
    def params_habitacion
        return params.require(:habitacion).permit(:nombre, :precio, :esta_reservada, :hotel_id)
    end

    def asignar_habitacion
        @habitacion = Habitacion.find_by(id: params[:id])
    end
end