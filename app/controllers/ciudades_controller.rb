class CiudadesController < ApplicationController

    def listar
        @lista_ciudades = Ciudad.all
    end

    def mostrar_formulario_crear
        @ciudad = Ciudad.new
    end

    def editar
        # recuperamos el :id de la URL 📦 y lo buscamos en la base de datos
        @ciudad = Ciudad.find_by(id: params[:id])
    end

    def guardar
        # extraer los datos del formulario 📦
        datos_formulario = params.require(:ciudad).permit(:nombre) # Hash
        # datos_formulario = {nombre: "Tokio"}
        # Guardando los datos 💾
        @ciudad = Ciudad.new
        @ciudad.nombre = datos_formulario[:nombre]
        if @ciudad.save
            # redirect_to "/ciudades"
            redirect_to ciudades_path
        else
            render :mostrar_formulario_crear
        end
    end
end