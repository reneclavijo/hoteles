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
        @habitacion = Habitacion.find(params[:id_habitacion])
        @usuario    = Usuario.find(cookies[:usuario_id])
        @reserva = Reserva.new(params_reserva)

        @reserva.habitacion = @habitacion
        @reserva.usuario    = @usuario
        @reserva.codigo         = SecureRandom.alphanumeric(5)
        if @reserva.save
            flash[:reserva_creada] = "Su reserva ha sido creada"
            redirect_to root_path
        else
            render :nueva
        end
    end

    private
    def params_reserva
        return params.require(:reserva).permit(:fecha_ingreso, :fecha_salida)
    end

end