Rails.application.routes.draw do
  get 'roles/nuevo',  to: 'roles#crear'
  post 'roles',       to: 'roles#guardar'
end
