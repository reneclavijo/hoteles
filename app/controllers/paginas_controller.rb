class PaginasController < ApplicationController

    layout 'layout_cliente' # Definiendo el layout a utilizar

    def principal

        if params[:busqueda]
            puts "BUSCANDO #{params[:busqueda]}".center(50, "🔍")
        end
    end
    
end