class CiudadesController < ApplicationController

    def listar
        @lista_ciudades = Ciudad.all
    end

    def mostrar_formulario_crear
        @ciudad = Ciudad.new
    end

    def guardar
        # extraer los datos del formulario 📦
        datos_formulario = params.require(:ciudad).permit(:nombre) # Hash
        # datos_formulario = {nombre: "Tokio"}
        # Guardando los datos 💾
        @ciudad = Ciudad.new
        @ciudad.nombre = datos_formulario[:nombre]
        if @ciudad.save
            # Mostrar la confirmación ✅
            puts "✅GUARDARDO✅".center(20, "*")
        else
            render :mostrar_formulario_crear
        end
    end
end