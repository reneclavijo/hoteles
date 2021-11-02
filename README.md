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

1. Registrar Hoteles

   1.1. Registrar al menos una ciudad

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















    - [ ] Solucionar la vista de `ciudades`

    - [ ] Actualziar un registro utilizando el formulario creado anteriormente

    - [ ] Eliminar una ciudad

   1.2. Formulario que me permita introducir los datos del hotel con 1 ciudad registrada en la BD

      - [ ] Consultar todas las ciudades de la BD
      - [ ] Diseñar el formulario para el registro de hotel (¿qué componentes necesitamos?)
      - [ ] Implementar la lógica que me permita guardar los datos del hotel con una ciudad

2. Registrar Habitaciones
3. Buscar hoteles (por nombre) 🔁
4. Reservar una habitación

### Opcionales

1. Iniciar sesión
2. Tener vistas de administrador
3. Buscador de hoteles por nombre en la página principal 🔁
