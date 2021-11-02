class CiudadesController < ApplicationController

    before_action :asignar_ciudad, only: [:editar, :actualizar, :eliminar]

    def listar
        @lista_ciudades = Ciudad.all
    end

    def mostrar_formulario_crear
        @ciudad = Ciudad.new
    end

    def editar
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

    def actualizar
        datos_formulario = params.require(:ciudad).permit(:nombre)
        @ciudad.nombre = datos_formulario[:nombre]
        if @ciudad.save
            redirect_to ciudades_path
        else
            render :editar
        end
    end

    def eliminar
        @ciudad.destroy
        redirect_to ciudades_path
    end

    private # Todo lo que está abajo 👇👇 es PRIVADO
    
    def asignar_ciudad
        # recuperamos el :id de la URL 📦 y lo buscamos en la base de datos
        @ciudad = Ciudad.find_by(id: params[:id])
        puts "ANTES ASIGNAR UNA CIUDAD".center(50, "🚥")
    end

end