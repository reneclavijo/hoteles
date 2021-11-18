class ApplicationController < ActionController::Base
    
    def validar_sesion_sin_redirigir
        if session[:usuario_id]
            @usuario_actual = Usuario.find(session[:usuario_id])
        end
    rescue
        session[:usuario_id] = nil
        @usuario_actual = nil
    end

    def validar_sesion_dirigiendo_al_registro
        if session[:usuario_id]
            @usuario_actual = Usuario.find(session[:usuario_id])
        else
            redirect_to registro_path
        end
    rescue
        # cookies.delete(:usuario_id)
        session[:usuario_id] = nil
        redirect_to registro_path
    end

    def validar_sesion_para_el_registro
        if session[:usuario_id]
            @usuario_actual = Usuario.find(session[:usuario_id])
            redirect_to root_path
        else
            @usuario_actual = nil
        end
    end

end
