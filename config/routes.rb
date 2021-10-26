Rails.application.routes.draw do
  get 'roles/nuevo', to: 'roles#crear'
end
