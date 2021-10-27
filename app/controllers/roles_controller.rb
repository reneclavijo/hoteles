# Lógica | Reciben peticiones y devuelven vistas
class RolesController < ApplicationController

    # GET /roles
    def listar
        @roles = Rol.all
    end

    # GET /roles/nuevo
    def crear
        # MOSTRAR formulario para guardar roles nuevos
        @mi_nombre = "rene r. clavijo"
        @rol = Rol.new
    end

    # POST /roles
    def guardar
        # extraer los datos del params
        datos_rol = params.require(:rol).permit(:rol)
        # asignando los datos a un nuevo rol
        @nuevo_rol = Rol.new(datos_rol)
        if @nuevo_rol.save
            redirect_to roles_path # => /roles
        else
            # tomar prestada una vista render
        end
    end

end