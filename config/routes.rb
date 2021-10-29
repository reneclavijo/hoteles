Rails.application.routes.draw do

  get 'roles',        to: 'roles#listar', as: 'roles'
  get 'roles/nuevo',  to: 'roles#crear'
  post 'roles',       to: 'roles#guardar'

  # Ciudades
  get   'ciudades',             to: 'ciudades#listar'                  ,  as: 'ciudades'
  get   'ciudades/nuevo',       to: 'ciudades#mostrar_formulario_crear',  as: 'nueva_ciudad'
  get   'ciudades/:id/editar',  to: 'ciudades#editar'
      #  ciudades/25/editar
  post  'ciudades',       to: 'ciudades#guardar'
end
