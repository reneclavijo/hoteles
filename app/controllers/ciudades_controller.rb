class CiudadesController < ApplicationController

    before_action :asignar_ciudad, only: [:mostrar, :editar, :actualizar, :eliminar]

    # GET /ciudades
    def listar
        @lista_ciudades = Ciudad.all
    end

    # GET /ciudades/nuevo
    def mostrar_formulario_crear
        @ciudad = Ciudad.new
    end

    # GET /ciudades/:id
    def mostrar
    end

    # GET /ciudades/:id/editar
    def editar
    end

    # POST /ciudades
    def guardar
        # Guardando los datos 💾
        @ciudad = Ciudad.new
        @ciudad.nombre = params_ciudad[:nombre]
        if @ciudad.save
            # redirect_to "/ciudades"
            redirect_to ciudades_path
        else
            render :mostrar_formulario_crear
        end
    end

    # PATH /ciudades/:id
    def actualizar
        @ciudad.nombre = params_ciudad[:nombre]
        if @ciudad.save
            redirect_to ciudades_path
        else
            render :editar
        end
    end

    # DELETE /ciudades/:id
    def eliminar
        @ciudad.destroy
        redirect_to ciudades_path
    rescue
        flash[:error_ciudad] = "No se puede eliminar la ciudad porque hay hoteles registrados en #{@ciudad.nombre}"
        redirect_to ciudades_path
    end

    private # Todo lo que está abajo 👇👇 es PRIVADO
    
    # recuperamos el :id de la URL 📦 y lo buscamos en la base de datos
    def asignar_ciudad
        @ciudad = Ciudad.find_by(id: params[:id])
        puts "ANTES ASIGNAR UNA CIUDAD".center(50, "🚥")
    end

    # extraer los datos del formulario 📦
    def params_ciudad
        return params.require(:ciudad).permit(:nombre)
    end
end