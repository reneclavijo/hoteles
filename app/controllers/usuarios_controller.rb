class UsuariosController < ApplicationController
  
  layout 'layout_cliente'
  before_action :validar_sesion_dirigiendo_al_registro, only: [:mostrar, :cerrar_sesion]
  
  def mostrar
  end

  # GET /iniciar_sesion
  def iniciar_sesion
    
  end

  # DELETE /cerrar_sesion
  def cerrar_sesion
    session[:usuario_id] = nil
    redirect_to root_path
  end
end
