# Enunciado

Una nueva comunidad de pequeños hoteles campestres 🌴🥥 desean automatizar las reservas para sus diferentes habitaciones y quisieran hacerlo a través de internet. Para ejemplificar el uso del mismo se decidió pensar en las siguientes acciones:

1. Registrar hoteles con sus nombre y cantidad de estrellas ⭐⭐⭐⭐⭐
2. Registrar habitaciones relacionadas a solo 1 hotel, que tengan un nombre o número así como el precio y también saber si está reservada o no 🚩
3. Un usuario que ingrese pueda navegar buscando hoteles y reservar una habitación que le interese, para ellos debería tener un nombre, número de identificación y teléfono 🛌

Cosas deseables del software serían las siguientes:

1. Al momento de registrar usuarios, que puedan iniciar sesión 🔐
2. Controlar el registro de hoteles y habitaciones con un usuario administrador para eso 👖
3. Tener un buscador de hoteles por el nombre en la página principal 🏩

## Funcionalidades

1. Registrar Hoteles (CRUD) ✅

   1.1. ✅ Registrar al menos una ciudad (CRUD Completo de ciudades)

    - [x] Experimentar en rails cómo se hace el ingreso de una ciudad a la tabla
       - Documentación para saber cómo se hace el [CRUD EN RAILS](https://guides.rubyonrails.org/active_record_basics.html#crud-reading-and-writing-data)

            ```ruby
            # Primera forma de registrar una ciudad
            ciudad = Ciudad.create(nombre: 'Moscú') # Automaticamente guarda el registro en la tabla

            # Segunda forma para registrar una ciudad
            ciudad = Ciudad.new
            ciudad.nombre = "Londres"
            ciudad.save

            # Tercera forma para registrar un ciudad
            ciudad = Ciudad.new do |c|
                c.nombre = "Berlín"
            end
            ciudad.save
            ```

    - [x] Mostrar un formulario para introducir los datos de una ciudad

        - [x] Definir un controlador *en plural* que se haga cargo de *mostrar* la vista

            ```ruby
            # app/controllers/ciudades_controller.rb
            class CiudadesController < ApplicationController
    
            end
            ```

        - [x] Crear una carpeta en *app/views* que se llame igual que el controlador

        - [x] Definir un método y una vista que tengan el mismo nombre y el archivo tenga la extensión *.html.erb*

        ```ruby
        # app/controllers/ciudades_controller.rb
        class CiudadesController < ApplicationController

            def mostrar_formulario_crear
                
            end
        end
        ```

        ```html
        <!-- app/views/ciudades/mostrar_formulario_crear.html.erb -->
        <h2>Registro de una ciudad</h2>

        <form>
            <label>Nombre</label>
            <input type="text">

            <button>Cancelar</button>
            <input type="submit" value="Registrar">
        </form>
        ```

        - [x] Agregar la ruta de acceso para la vista (modificar el archivo *config/routes.rb*)

        ```ruby
        # config/routes.rb  
        get 'ciudades/nuevo', to: 'ciudades#mostrar_formulario_crear'
        ```
  
    - [x] Agregar la lógica para guardar los datos en la tabla de ciudades

      - [x] Entender el funcionamiento del formulario
      - [x] Configurar el formulario para que envíe los datos donde tienen que ir (usar *form_with* "ayudante" de Rails)
      - [x] Construir el formulario *form_with* en base a un modelo
      - [x] Agregar la ruta para permitir el acceso de los datos (utilizar un *POST*)
      - [x] Definir un método que reciba los datos y los guarde (Utilizar el modelo Ciudad según lo aprendido)
      - [x] Mostrar algo de confirmación
      - [x] Evidencias

        ```html
        <!-- app/views/ciudades/mostrar_formulario_crear.html.erb -->
        <h2>Registro de una ciudad</h2>

        <%= form_with(model: @ciudad) do |formulario| %>
            
            <!-- <label id="nombre" >Nombre</label> -->
            <%= formulario.label :nombre %>
            <!-- <input type="text" id="nombre" name="nombre"> -->
            <%= formulario.text_field :nombre %>

            <button>Cancelar</button> <!-- link_to -->

            <!-- <input type="submit" value="Registrar"> -->
            <%= formulario.submit 'Registrar' %>

        <% end %>
        ```

        ```ruby
        # app/controller/ciudades_controller.rb
        class CiudadesController < ApplicationController

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
                @ciudad.save
                # Mostrar la confirmación ✅
                puts "✅GUARDARDO✅".center(20, "*")
            end
        end
        ```

        ```ruby
        # config/routes.rb
        # Ciudades  
        get   'ciudades/nuevo', to: 'ciudades#mostrar_formulario_crear'
        post  'ciudades',       to: 'ciudades#guardar'
        ```

    - [x] Listar todas las ciudades en una nueva vista

        - [x] Configurar la ruta GET /ciudades

        - [x] Definir el método `listar` en el controlador de ciudades

        - [x] Crear un archivo nuevo llamado `listar.html.erb` en la carpeta de `app/views/ciudades`

        - [x] Diseñar la lógica para mostrar todas las ciudades en la vista

        - [X] Consultar todos los registro de la tabla `ciudades`

            ```ruby
            # app/controllers/ciudades_controller.rb
            def listar
                @lista_ciudades = Ciudad.all
            end
            ```

        - [x] Recorrer todos los registros y mostrarlos en etiquetas HTML

            ```html
            <h1>Lista de ciudades registradas</h1>

            <table>
                <tr>
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Acciones</th>
                </tr>
                <% @lista_ciudades.each do |c| %>
                    <tr>
                        <td>
                            <%= c.id %>
                        </td>            
                        <td>
                            <%= c.nombre %>
                        </td>
                        <td>
                            <span>Editar</span>
                            <span>Eliminar</span>
                        </td>
                    </tr>
                <% end %>
            </table>
            ```

    - [x] Validar que no se puedan crear ciudades SIN nombre y tampoco repetidas

        - [x] Agregar las validaciones necesarias al modelo

            ```ruby
            class Ciudad < ApplicationRecord
                has_many :hoteles # una ciudad tiene muchos hoteles

                validates :nombre, presence: true
                validates :nombre, uniqueness: true
            end
            ```

        - [x] Asegurarnos de tener el método `.save` en un `if` en el controlador para pedirnos prestado una vista (con `render`) en caso de fallar

            ```ruby
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
            ```

        - [x] Mostrar los errores (si los hubiera) en la vista

            ```ruby
            <h2>Registro de una ciudad</h2>

            <%= form_with(model: @ciudad) do |formulario| %>
                
                <!-- <label id="nombre" >Nombre</label> -->
                <%= formulario.label :nombre %>
                <!-- <input type="text" id="nombre" name="nombre"> -->
                <%= formulario.text_field :nombre %>
                <% if @ciudad.errors[:nombre].any? %>
                    <div>
                        <%= @ciudad.errors[:nombre].first %>
                    </div>
                <% end %>

                <button>Cancelar</button> <!-- link_to -->

                <!-- <input type="submit" value="Registrar"> -->
                <%= formulario.submit 'Registrar' %>

            <% end %>
            ```

    - [x] Redirigir a la vista de `listar` cuando el formulario sea exitoso

        - [x] Agregar el método `redirect_to` en el controlador

            ```ruby
            # app/controllers/ciudades_controller.rb
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
            ```

        - [x] Agregar el alias a la ruta de ciudades

            ```ruby
            # config/routes.rb
             # Ciudades
            get   'ciudades',       to: 'ciudades#listar', as: 'ciudades'
            ```

    - [x] Mostrar un formulario para editar el nombre de una ciudad

      - [x] Experimentar con la etiqueta `link_to` que me permite generar etiquetas `<a>`

        ```html
        <!-- app/views/ciudades/listar.html.erb -->
        <%= link_to "Crear nueva ciudad", nueva_ciudad_path %>
        ```

        ```ruby
        # config/routes.rb
        get   'ciudades/nuevo', to: 'ciudades#mostrar_formulario_crear',  as: 'nueva_ciudad'
        ```

      - [x] Convertir el texto "Editar" en un link para mostrar la vista de editar

      - [x] Entender cómo funciona una actualización de datos

        ```ruby
        # primera forma de actualizar un dato
        ciudad = Ciudad.find_by(id: 18)         # 1. Buscar el registro por ID
        ciudad.nombre = "arequipa"              # 2. Cambiar el dato de los campos que me interesa
        ciudad.save                             # 3. Guardar los cambios en la BD

        # segunda forma de actualizar un dato
        ciudad = Ciudad.find_by(id: 16)         # 1. Buscar el registro por ID
        ciudad.update(nombre: 'Seul')           # 2. Actualizar el registro con el método .update
        ```

      - [x] Habilitar la ruta para mostrar el formulario para editar una ciudad

        ```ruby
        # config/routes.rb
         get   'ciudades/:id/editar',  to: 'ciudades#editar'
        ```

      - [x] Definir el método en el controlador de ciudades que se haga cargo de la vista de editar

        ```ruby
        # app/controllers/ciudades_controller.rb
        def editar
            
        end
        ```

      - [x] Crear el archivo `editar.html.erb` que muestre el formulario para editar el nombre de la ciudad

      - [x] Entender cómo enviar variables por la URL (para qué sirve el ciudades/:id/editar) y recibirlas

        ```ruby
        def editar
            # recuperamos el :id de la URL 📦 
            id = params[:id]
            puts "#{id}".center(50, "-")
        end
        ```

      - [x] Definir la lógica para mostrar el formulario con datos cargados de la BD

        - [x] Obtener el :id que llega desde la URL

        - [x] Buscar la ciudad en la base de datos

            ```ruby
            def editar
                # recuperamos el :id de la URL 📦 y lo buscamos en la base de datos
                @ciudad = Ciudad.find_by(id: params[:id])
            end
            ```

        - [x] Mostrar la información de la búsqueda

            ```html
            <h1>Editar</h1>

            <%= @ciudad.id %>
            <%= @ciudad.nombre %>
            ```

        - [x] Mostrar la información dentro de un formulario

            ```ruby
            # config/routes.rb
              patch 'ciudades/:id',   to: 'ciudades#actualizar', as: 'ciudad'

            ```

            ```html
            <!-- app/views/ciudades/editar.html.erb -->
            <h1>Editar</h1>

            <%= form_with(model: @ciudad) do |formulario| %>

                <%= formulario.label        :nombre %>
                <%= formulario.text_field   :nombre %>
                <% if @ciudad.errors[:nombre].any? %>
                    <div>
                        <%= @ciudad.errors[:nombre].first %>
                    </div>
                <% end %>

                <button>Cancelar</button>
                
                <%= formulario.submit "Actualizar" %>
            <% end %>
            ```

    - [x] Solucionar la vista de `ciudades`

    - [x] Actualizar un registro utilizando el formulario creado anteriormente

      - [x] Definir un método en controlador de `ciudades` que se haga cargo de actualizar
      - [x] Extraer los datos del formulario dentro *params*
      - [x] Buscar el registro en la base de datos
      - [x] Asignar los nuevos valores al objeto encontrado
      - [x] Guardar / Actualizar el nuevo objeto
      - [x] Redirigir o mostrar la vista prestada `editar`

      ```ruby
      # app/controllers/ciudades_controller.rb
        def actualizar
            datos_formulario = params.require(:ciudad).permit(:nombre)
            @ciudad = Ciudad.find_by(id: params[:id])
            @ciudad.nombre = datos_formulario[:nombre]
            if @ciudad.save
                redirect_to ciudades_path
            else
                render :editar
            end
        end
      ```

    - [x] Eliminar una ciudad

      - [x] Entender cómo funciona *eliminar* en Rails

        ```ruby
        # Forma 1
        cuidad = Ciudad.find_by(id: 22)
        ciudad.destroy

        # Forma 2
        ciudad = Ciudad.destroy_by(id: 19)

        # Forma 3 ⚠ ELIMINAR TODO
        ciudades_eliminadas = Ciudad.destroy_all
        ```

      - [x] Definir la ruta DELETE

          ```ruby
          # config/routes
          delete  'ciudades/:id',   to: 'ciudades#eliminar'
          ```

      - [x] Convertir en botón al texto *Eliminar* del archivo `listar.html.erb` de ciudades

          ```ruby
          # app/views/ciudades/listar.html.erb
          <%= link_to "Eliminar", ciudad_path(c), method: :delete %>
          ```

      - [x] Definir el método que se hará cargo en el controlador *ciudades*

          ```ruby
          # app/controller/ciudades_controller.rb
          def eliminar
          
          end
          ```

      - [x] Definir la lógica para eliminar el registro

      - [x] Redirigir a *ciudades_path*

          ```ruby
          def eliminar
              @ciudad = Ciudad.find_by(id: params[:id])
              @ciudad.destroy
              rediret_to ciudades_path
          end
          ```

    - [x] Limpiar controlador de ciudades

      - [x] Entender qué son los filtros

        ```ruby
        # app/controllers/ciudades_controller.rb
        class CiudadesController < ApplicationController

            before_action :antes_de_la_accion
            after_action  :despues_de_la_accion

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

            def actualizar
                datos_formulario = params.require(:ciudad).permit(:nombre)
                @ciudad = Ciudad.find_by(id: params[:id])
                @ciudad.nombre = datos_formulario[:nombre]
                if @ciudad.save
                    redirect_to ciudades_path
                else
                    render :editar
                end
            end

            def eliminar
                @ciudad = Ciudad.find_by(id: params[:id])
                @ciudad.destroy
                redirect_to ciudades_path
            end

            private # Todo lo que está abajo 👇👇 es PRIVADO
            
            def antes_de_la_accion
                puts "ANTES 🚥".center(50, "*")
            end

            def despues_de_la_accion
                puts "DESPUES 😴".center(50, "*")
            end

        end
        ```

      - [X] Utilizarlos para evitar duplicar código al asignar una ciudad

        ```ruby
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
        ```

      - [x] Utilizar un método *params_ciudad* para extraer los datos del formulario en 1 solo lugar

        ```ruby
        # app/controllers/ciudades_controller.rb
        class CiudadesController < ApplicationController

            before_action :asignar_ciudad, only: [:editar, :actualizar, :eliminar]

            # GET /ciudades
            def listar
                @lista_ciudades = Ciudad.all
            end

            # GET /ciudades/nuevo
            def mostrar_formulario_crear
                @ciudad = Ciudad.new
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
        ```

   1.2. Configuración de Bootstrap con yarn

    - [x] Instalar yarn

        ```bash
        # Nos funcionó con gitbash
        npm -v
        npm install -g yarn
        yarn -v
        ```

    - [x] Agregar los paquetes de bootstrap

        ```bash
        yarn add bootstrap
        ```

    - [x] Agregar los paquetes de popperjs

        ```bash
        yarn add @popperjs/core
        ```

    - [x] Crear el directorio *css* en la carpeta *app/ javascript*

    - [x] Crear el archivo de inicio *main.scss*

    - [x] Importar a *app/javascript/application.js* el paquete de bootstrap

        ```javascript
        // app/javascript/packs/application.js
        // This file is automatically compiled by Webpack, along with any other files
        // present in this directory. You're encouraged to place your actual application logic in
        // a relevant structure within app/javascript and only use these pack files to reference
        // that code so it'll be compiled.

        import Rails from "@rails/ujs"
        import Turbolinks from "turbolinks"
        import * as ActiveStorage from "@rails/activestorage"
        import "channels"

        // Configurado JS de bootstrap
        import 'bootstrap'  
        // Configura CSS de bootstrap
        import 'css/main'   

        Rails.start()
        Turbolinks.start()
        ActiveStorage.start()
        ```

        ```scss
        // app/javascript/css/main.scss
        @import '~bootstrap/scss/bootstrap';
        ```

   1.3. Crear un parcial para el menú lateral

    - [x] Crear un archivo que comienza con *_menu_vertical.html.erb*. RECORDAR: debe comenzar con _

    - [x] Llamar el parcial en la vista que quiera

   1.4. CRUD Hoteles

    1.4.1. Crear un Hotel con un ciudad

      - [x] La ruta para mostrar el formulario
      - [x] El controlador con el método
      - [x] La vista para mostrar el formulario
      - [x] Crear un hotel por consola para aprender cómo funciona

        ```ruby
        # Primera forma de registrar por referencia
        ciudad = Ciudad.find_by(id: 29) # me trae la ciudad con id 29
        hotel = Hotel.new
        hotel.nombre = "Las colinas"
        hotel.estrellas = 5
        hotel.ciudad = ciudad
        hotel.save

        # Segunda forma de registrar por el ID de la ciudad
        hotel = Hotel.new
        hotel.nombre = "Los balcones"
        hotel.estrellas = 2
        hotel.ciudad_id = 35 # id de la ciudad
        hotel.save
        ```

      - [x] Consultar todas las ciudades de la BD

        ```ruby
        # app/controllers/hoteles_controller.rb
        # GET /hoteles/nuevo
        def nuevo
            @hotel = Hotel.new
            @ciudades = Ciudad.all
        end
        ```

      - [x] Diseñar el formulario para el registro de hotel (¿qué componentes necesitamos?)

        ```htm
        <!-- app/views/hoteles/nuevo.html.erb -->
        <h1>FORMULARIO para el hotel</h1>

        <%= form_with(model: @hotel) do |formulario| %>
            <div class="mb-3">
                <%= formulario.label        :nombre, class: 'form-label' %>
                <%= formulario.text_field   :nombre, class: 'form-control' %>
                <% if @hotel.errors[:nombre].any? %>
                    <div>
                        <%= @hotel.errors[:nombre].first %>
                    </div>
                <% end %>
            </div>

            <div class="mb-3">
                <%= formulario.label        :estrellas, class: 'form-label' %> 
                <%= formulario.number_field :estrellas, class: 'form-control' %>
                <% if @hotel.errors[:estrellas].any? %>
                    <div>
                        <%= @hotel.errors[:estrellas].first %>
                    </div>
                <% end %>
            </div>

            <div class="mb-3">
                <%= formulario.label    :ciudad_id %>
                <%= formulario.select   :ciudad_id,
                    options_from_collection_for_select(@ciudades, :id, :nombre, @hotel.ciudad_id),
                    { include_blank: "Selecciona la ciudad del hotel" },
                    class: 'form-select' %>
                <% if @hotel.errors[:ciudad_id].any? %>
                    <div>
                        <%= @hotel.errors[:ciudad_id].first %>
                    </div>
                <% end %>
            </div>

            <%= formulario.submit "Crear" %>

        <% end %>
        ```

      - [x] Implementar la lógica que me permita guardar los datos del hotel con una ciudad

        ```ruby
        # app/controllers/hoteles_controller.rb
        # POST /hoteles
        def guardar
            @hotel = Hotel.new(params_hotel)
            if @hotel.save
                # redirect_to hoteles_path # listar hoteles
            else
                @ciudades = Ciudad.all
                render :nuevo
            end
        end

        private
        def params_hotel
            return params.require(:hotel).permit(:nombre, :estrellas, :ciudad_id)
        end
        ```

    1.4.2. Listar los hoteles registrados

      - [x] Definir la ruta
      - [x] Tener el método que se hará cargo
      - [x] La vista
      - [x] Agregar al menu de navegación
      - [x] Agregar la lógica para mostrar hoteles en la vista

    1.4.3. Actualizar los hoteles registrados

      - [x] Definir la ruta
      - [x] Definir el método *editar* que se hará cargo
      - [x] Crear la vista
      - [x] Convertir a botón el texto Editar en *listar.html.erb*
      - [x] Agregar la lógica para actualizar el hotel

    1.4.4. Eliminar un hotel registrado

      - [x] Definir la ruta
      - [x] Agregar el botón
      - [x] Agregar la pregunta
      - [x] Agregar la lógica para eliminar un hotel

    CALLBACKS

      - [x] Experimentar para ver cómo se comportan los callbacks
      - [x] Implementar un callback que normalice los nombres de los registros

    RESCUE

      - [x] Capturar errores en los métodos utilizando rescue

2. Registrar Habitaciones ✅

    2.1. Crear habitaciones ✅
    2.2. Consultar/Listar habitaciones ✅
    2.3. Actualizar habitaciones
    2.4. Eliminar ✅

3. Buscar hoteles (por nombre) 🔁

    3.1. Diseñar un wireframe

     - [x] Encontrar una referencia
     - [x] Diseñar un wireframe

    3.2. Configurar las rutas

     - [x] Definir una ruta para la vista principal

        ```ruby
        # config/routes.rb
        # Principal
        root 'paginas#principal'
        ```

    3.3. Definir el controlador que se hará cargo de la vista

     - [x] Crear el archivo `paginas_controller.rb`
     - [x] Definir el método `principal`
     - [x] Crear el archivo en `app/views/paginas/principal.html.erb`

        3.3.1. Crear un layout específico para los clientes

          - [x] Crear el archivo en la carpeta de *app/views/layouts/layout_cliente.html.erb*
          - [x] Definir en el controlador el layout a utilizar
          - [x] Definir la estructura HTML del nuevo layout

    3.4. Definir el método que se hará cargo de la lógica

     - [x] En la vista colocar un *input* para escribir el nombre de ciudad/hotel
     - [x] Analizar la lógica para mostrar el resultado
     - [ ] Definir las tarjetas donde se mostrará el resultado

       - [x] Crear un archivo nuevo que se llame *_tarjeta.html.erb* en la carpeta *app/views/paginas*
       - [x] Definir una ruta para mostrar la información de 1 solo hotel

       ```ruby
       #config/routes.rb
        get   'paginas/:id_hotel', to: 'paginas#info_hotel', as: 'info_hotel'
       ```

       - [x] Definir el método que  mostrará la vista en el controlador de páginas

       ```ruby
       
        # GET /paginas/:id_hotel
        def info_hotel
            
        end
       ```

       - [x] Crear el archivo *info_hotel.html.erb* para mostrar la información detallada del hotel

4. Reservar una habitación

### Opcionales

1. Iniciar sesión

   - [ ] Un botón que nos envíe al formulario para registrarnos
   - [ ] Definir una ruta que permita mostrar el formulario de registro
   - [ ] Definir un controlador y método que se haga cargo del formulario
   - [ ] Crear el archivo de la vista con el formulario
   - [ ] Definir un método para la lógica de registro de usuario
   - [ ] Definir un método para la lógica de iniciar sesión

2. Tener vistas de administrador
3. Buscador de hoteles por nombre en la página principal 🔁
