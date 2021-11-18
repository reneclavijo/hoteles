class UsuariosController < ApplicationController
  
  layout 'layout_cliente'
  before_action :validar_sesion_dirigiendo_al_registro, only: [:mostrar, :cerrar_sesion, :actualizar]
  before_action :validar_sesion_para_el_registro, only: [:iniciar_sesion]

  def mostrar
  end

  # GET /iniciar_sesion
  def iniciar_sesion
    
  end

  # POST /iniciar_sesion
  def crear_sesion
    usuario_encontrado = Usuario.find_by(identificacion: params[:identificacion])
    if usuario_encontrado # ¿El usuario existe?
      if usuario_encontrado.authenticate(params[:password])
        session[:usuario_id] = usuario_encontrado.id
        redirect_to root_path
      else
        flash[:error_iniciar_sesion] = "Password incorrecto"
        render :iniciar_sesion
      end
    else
      flash[:error_iniciar_sesion] = "Usuario no encontrado"
      render :iniciar_sesion
    end
  end

  def actualizar
    if @usuario_actual.update(params_usuario) # lo que hacíamos manual, lo hace en 1 sola línea
      flash[:actualizar_usuario] = "Datos actualizados"
      redirect_to usuario_path
    else
      render :mostrar
    end
  end

  # DELETE /cerrar_sesion
  def cerrar_sesion
    session[:usuario_id] = nil
    redirect_to root_path
  end

  private
  def params_usuario
    params.require(:usuario).permit(:nombre, :identificacion, :telefono, :password, :password_confimation)
  end
end
