class ReservasController < ApplicationController

    layout 'layout_cliente'
    
    # GET /reservas/:id_habitacion
    def nueva
        @habitacion = Habitacion.find(params[:id_habitacion])
        @usuario    = Usuario.find(cookies[:usuario_id])
        @reserva    = Reserva.new
    end

    # POST /reservas/:id_habitacion
    def guardar
        @habitacion = Habitacion.find(params[:id_habitacion])       # 1. Obtener el ID del habitación desde params
        @usuario    = Usuario.find(cookies[:usuario_id])            # 2. Obtener el ID del Usuario 👦 desde la cookie
        @reserva    = Reserva.new(params_reserva)                   # 3. Crear un objeto de tipo Reserva con la fechas del formulario

        @reserva.habitacion = @habitacion                           # 4. Asignar los valores a la reserva
        @reserva.usuario    = @usuario
        @reserva.codigo     = SecureRandom.alphanumeric(5).upcase   # 5. Crear un código de reserva "seguro" alfanumérico

        if @reserva.save                                            # 6. Intentar guardar la reserva en la Base de datos
            flash[:reserva_creada] = "Su reserva ha sido creada"        # 6.1. EXITO => Mostrar un mensaje de validación
            redirect_to root_path                                       # Redirigir a la raíz de la aplicación
        else                                                            # 6.2. FALSO =>
            render :nueva                                               # Mostrar el formulario :nueva para mostrar los errores
        end
    end

    private
    def params_reserva
        return params.require(:reserva).permit(:fecha_ingreso, :fecha_salida)
    end

end