class ReservasController < ApplicationController

    layout 'layout_cliente'
    
    # GET /reservas/:id_habitacion
    def nueva
        @habitacion = Habitacion.find(params[:id_habitacion])
        @usuario    = Usuario.find(cookies[:usuario_id])
        @reserva    = Reserva.new
    end

    # POST
    def guardar
    end

end