Rails.application.routes.draw do
  get 'roles',        to: 'roles#listar', as: 'roles'
  get 'roles/nuevo',  to: 'roles#crear'
  post 'roles',       to: 'roles#guardar'
end
