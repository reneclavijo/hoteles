class RegistrosController < ApplicationController

    layout 'layout_cliente'
    before_action :validar_sesion_para_el_registro

    # GET /registro
    def nuevo
        @usuario = Usuario.new
    end    
    
    # POST /registros
    def guardar
        @usuario = Usuario.new(params_usuario)
        @usuario.rol = Rol.find_by(rol: 'Cliente')
        if @usuario.save
            session[:usuario_id] = @usuario.id # Definiendo la cookie que mantendrá la sesión
            redirect_to root_path
        else
            render :nuevo
        end
    end

    private 

    def params_usuario
        return params
        .require(:usuario)
        .permit(:nombre, :identificacion, :telefono, :password, :password_confirmation)
    end
end