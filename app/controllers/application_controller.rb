class ApplicationController < ActionController::Base
    
    def validar_sesion_sin_redirigir
        if cookies[:usuario_id]
            @usuario_actual = Usuario.find(cookies[:usuario_id])
        end
    rescue
        @usuario_actual = nil
    end

    def validar_sesion_dirigiendo_al_registro
        if cookies[:usuario_id]
            @usuario_actual = Usuario.find(cookies[:usuario_id])
        else
            redirect_to registro_path
        end
    rescue
        cookies.delete(:usuario_id)
        redirect_to registro_path
    end

    def validar_sesion_para_el_registro
        if cookies[:usuario_id]
            redirect_to root_path
        else
            @usuario_actual = nil
        end
    end

end
