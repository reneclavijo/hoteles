class UsuariosController < ApplicationController
  
  layout 'layout_cliente'
  before_action :validar_sesion_dirigiendo_al_registro
  
  def mostrar
  end
end
