Rails.application.routes.draw do

  # Roles
  get 'roles',              to: 'roles#listar', as: 'roles'
  get 'roles/nuevo',        to: 'roles#nuevo',  as: 'nuevo_rol'
  get 'roles/:id/editar',   to: 'roles#editar', as: 'editar_rol'

  post    'roles',        to: 'roles#guardar'
  patch   'roles/:id',    to: 'roles#actualizar', as: 'rol'
  delete  'roles/:id',    to: 'roles#eliminar'

  # Ciudades
  get   'ciudades',             to: 'ciudades#listar'                  ,  as: 'ciudades'
  get   'ciudades/nuevo',       to: 'ciudades#mostrar_formulario_crear',  as: 'nueva_ciudad'
  get   'ciudades/:id/editar',  to: 'ciudades#editar',                    as: 'editar_ciudad'

  post    'ciudades',       to: 'ciudades#guardar'
  patch   'ciudades/:id',   to: 'ciudades#actualizar', as: 'ciudad'
  delete  'ciudades/:id',   to: 'ciudades#eliminar'

  # Hoteles
  get 'hoteles',            to: 'hoteles#listar', as: 'hoteles'
  get 'hoteles/nuevo',      to: 'hoteles#nuevo',  as: 'nuevo_hotel'
  get 'hoteles/:id/editar',  to: 'hoteles#editar', as: 'editar_hotel'

  post 'hoteles', to: 'hoteles#guardar'
  patch 'hoteles/:id',      to: 'hoteles#actualizar', as: 'hotel'

end
