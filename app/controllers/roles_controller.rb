# Lógica | Reciben peticiones y devuelven vistas
class RolesController < ApplicationController

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
            # por verdad mostrar algo redirect_to
        else
            # tomar prestada una vista render
        end
    end

end