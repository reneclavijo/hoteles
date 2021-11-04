# Lógica | Reciben peticiones y devuelven vistas
class RolesController < ApplicationController
    before_action :asignar_rol, only: [:editar, :actualizar, :eliminar]
    # GET /roles
    def listar
        @roles = Rol.all
    end

    # GET /roles/nuevo
    def nuevo
        # MOSTRAR formulario para guardar roles nuevos
        # @mi_nombre = "rene r. clavijo"
        @rol = Rol.new
    end

    # GET /roles/:id/editar
    def editar
        
    end 

    # POST /roles
    def guardar
        # asignando los datos a un nuevo rol
        @nuevo_rol = Rol.new(params_rol)
        if @nuevo_rol.save
            redirect_to roles_path # => /roles
        else
            render :nuevo
        end
    end

    def actualizar
        @rol.rol = params_rol[:rol]
        if @rol.save
            redirect_to roles_path
        else
            render :editar
        end
    end

    def eliminar
        @rol.destroy
        redirect_to roles_path
    end

    private
    def params_rol
        return params.require(:rol).permit(:rol)
    end

    def asignar_rol
        @rol = Rol.find_by(id: params[:id])
    end
end