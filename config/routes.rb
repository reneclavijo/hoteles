Rails.application.routes.draw do

  # Principal
  root 'paginas#principal'


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
  get   'ciudades/:id',         to: 'ciudades#mostrar',                   as: 'ciudad'

  post    'ciudades',       to: 'ciudades#guardar'
  patch   'ciudades/:id',   to: 'ciudades#actualizar'
  # put     'ciudades/:id',   to: 'ciudades#actualizar' # hace lo mismo que el patch (actualizar)
  delete  'ciudades/:id',   to: 'ciudades#eliminar'

  # Hoteles
  get 'hoteles',                      to: 'hoteles#listar', as: 'hoteles'
  get 'hoteles/nuevo',                to: 'hoteles#nuevo',  as: 'nuevo_hotel'
  get 'hoteles/nuevo/:id_ciudad',     to: 'hoteles#nuevo',  as: 'nuevo_hotel_con_ciudad'
  get 'hoteles/:id/editar',           to: 'hoteles#editar', as: 'editar_hotel'

  post    'hoteles',        to: 'hoteles#guardar'
  patch   'hoteles/:id',    to: 'hoteles#actualizar', as: 'hotel'
  delete  'hoteles/:id',    to: 'hoteles#eliminar'

  # Habitaciones

  get 'habitaciones',             to: 'habitaciones#listar',  as: 'habitaciones'
  get 'habitaciones/nueva',       to: 'habitaciones#nueva',   as: 'nueva_habitacion'
  get 'habitaciones/:id',         to: 'habitaciones#mostrar', as: 'habitacion' # Mostrar la info de 1 habitación
  get 'habitaciones/:id/editar',  to: 'habitaciones#editar',  as: 'editar_habitacion'

  post    'habitaciones',            to: 'habitaciones#guardar'
  put     'habitaciones/:id',        to: 'habitaciones#editar' # Hace lo mismo que el PATCH 
  patch   'habitaciones/:id',        to: 'habitaciones#editar' 
  delete  'habitaciones/:id',        to: 'habitaciones#eliminar'
end
