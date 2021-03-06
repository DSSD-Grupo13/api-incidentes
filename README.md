# API de Incidentes

Esta API consiste en un webservice REST que permite a la aseguradora SSA gestionar sus clientes y sus incidentes

Esta implementado utilizando las tecnologias PHP, Apache y el framework Slim

## Endpoints

1. `'/'` --> Documentación

    Un requerimiento `HTTP GET` a la URL `'/'` retorna este documento

2. `'/incidente/{:id_incidente}'` --> Retorna los datos de un incidente

    Se debe enviar un requerimiento `HTTP GET` a la URL `/incidente/{:id}`.

    La respuesta es un objeto `JSON` que contiene los datos del incidente:

        HTTP 200 OK

    ```JSON
    {
        "id": "73",
        "descripcion": " choque",
        "cliente": {
            "id": "1",
            "apellido": "lopez",
            "nombre": "maria",
            "mail": "mlopez@gmail.com"
        },
        "tipo": {
            "id": "3",
            "nombre": "vehiculo"
        },
        "estado": {
            "id": "1",
            "nombre": "pendiente"
        },
        "fecha": "11-11-2017",
        "objetos": [
            {
                "nombre": "parabrisas",
                "cantidad": "2",
                "descripcion": "el granizo estallo el vidrio"
            },
            {
                "nombre": "puerta",
                "cantidad": "1",
                "descripcion": "puerta del conductor esta abollada"
            }
        ]
    }
    ```

3. `'/incidentes'` --> Retorna la lista de incidentes

    Se debe enviar un requerimiento `HTTP GET` a la URL `/incidente`.

    La respuesta es un array de objetos `incidente` en formato `JSON`. Ver `GET '/incidente/{:id_incidente}'`

4. `'/incidentes/{:id_usuario}'` --> Retorna la lista de incidentes de un usuario

    Se debe enviar un requerimiento `HTTP GET` a la URL `/incidentes/{:id_usuario}`.

    El parametro incluido en la URL debe ser el identificador del usuario que se quiere consultar

    La respuesta es un array de objetos `incidente` en formato `JSON`. Ver `GET '/incidente/{:id_incidente}'`

5. `'/incidentes'` --> Registrar incidente

    Se debe enviar un requerimiento `HTTP POST` a la URL `/incidentes`

    La solicitud debe incluir en el `body` un objeto `JSON` en donde se indiquen los siguientes parametros: `idUsuario`, `descripcion` y un array de `objetos` a indemnizar

    Ejemplo:

    ```JSON
    {
      "idUsuario": "1",
      "descripcion": "granizo",
      "objetos": [
        {
          "nombre": "parabrisas",
          "cantidad": "1",
          "descripcion": "el vidrio fue estallado por el granizo"
        }
      ]
    }
    ```

    Todos los parámetros serán validados:

    * `IdUsuario` debe ser el de un usuario registrado en el sistema
    * `descripcion`: string
    * `objetos`: es un array con los objetos a indemnizar. Para cada elemento se debe consignar:
        * `nombre`: nombre del objeto
        * `cantidad`: cantidad de objetos requerida
        * `descripcion`: descripcion del incidente sobre el objeto

    Esto devuelve una respuesta en donde el `body` es un objeto `JSON` con la siguiente estructura:

        HTTP 200 OK

    ```JSON
    {
      "idIncidente": "integer",
      "message": "string",
      "error_code": "integer"
    }
    ```

    Donde:

    * `idIncidente`: contiene un `id` que es el identificador asignado por el sistema
    * `message`: contiene un texto descriptivo del resultado de la operación
    * `error_code`: este campo unicamente se incluye  cuando la respuesta `HTTP` vuelve con un `Status Code 400 Bad Request`. Es un codigo de error cuyo significado puede consultarse en el endpoint `/error-code/{:id_error_code}`

    ##### Ejemplo incidente creado correctamente:

        HTTP 200 OK

    ```JSON
    {
        "message": "Se confirmó el expediente # 2",
        "idIncidente": "2"
    }
    ```

    ##### Ejemplo error:

        HTTP 400 Bad Request

    ```JSON
    {
        "error_code": "1",
        "message": "El usuario indicado no existe en el sistema",
        "idIncidente": ""
    }
    ```

6. `'/tipos-incidente'` --> Retorna la lista de tipos de incidente

    Se debe enviar un requerimiento `HTTP GET` a la URL `/tipos-incidente`.

    La respuesta es un array de objetos `JSON` que contiene los datos de los diferentes tipso de incidents:

        HTTP 200 OK

    ```JSON
    [
        {
            "idTipoIncidente": "1",
            "nombre": "casa"
        },
        {
            "idTipoIncidente": "2",
            "nombre": "vehiculo"
        },
        {
            "idTipoIncidente": "3",
            "nombre": "objeto-mueble"
        }
    ]
    ```

7. `'/tipos-incidente/{:id_tipo_incidente}'` --> Consulta de tipo de incidente

    Se debe enviar un requerimiento `HTTP GET` a la URL `/tipos-incidente/{:id_tipo_incidente}`.

    El parametro incluido en la URL es un identificador del tipo de incidente que se quiere consutlar

    La respuesta es un objeto `JSON` con la siguiente estructura:

        HTTP 200 OK

    ```JSON
    {
        "idTipoIncidente": "1",
        "nombre": "casa"
    }
    ```

8. `'/estados-incidente'` --> Retorna la lista de estados de incidente

    Se debe enviar un requerimiento `HTTP GET` a la URL `/estados-incidente`.

    La respuesta es un array de objetos `JSON` que contiene los datos de los diferentes estados de los incidentes:

        HTTP 200 OK

    ```JSON
    [
        {
            "idEstado": "1",
            "nombre": "pendiente"
        },
        {
            "idEstado": "2",
            "nombre": "en-presupuesto"
        }
    ]
    ```

9. `'/estados-incidente/{:id_estado_incidente}'` --> Consulta de estado de incidente

    Se debe enviar un requerimiento `HTTP GET` a la URL `/tipos-incidente/{:id_tipo_incidente}`.

    El parametro incluido en la URL es un identificador del estado de incidente que se quiere consutlar

    La respuesta es un objeto `JSON` con la siguiente estructura:

        HTTP 200 OK

    ```JSON
    {
        "idEstado": "1",
        "nombre": "pendiente"
    }
    ```

10. `'/usuarios'` --> Retorna la lista de usuarios registrados

    Se debe enviar un requerimiento `HTTP GET` a la URL `/usuarios`.

    La respuesta es un array de objetos `JSON` que contiene los datos de los usuarios registrados

        HTTP 200 OK

    ```JSON
    [
        {
            "id": "1",
            "nombreUsuario": "mlopez",
            "contrasena": "bpm",
            "email": "mlopez@gmail.com",
            "dni": "38951674",
            "nombre": "maria",
            "apellido": "lopez"
        },
        {
            "id": "2",
            "nombreUsuario": "mgomez",
            "contrasena": "bpm",
            "email": "mgomez@gmail.com",
            "dni": "37694301",
            "nombre": "mateo",
            "apellido": "gomez"
        },
        {
            "id": "3",
            "nombreUsuario": "jrodriguez",
            "contrasena": "bpm",
            "email": "jrodriguez@gmail.com",
            "dni": "36950167",
            "nombre": "juan",
            "apellido": "rodriguez"
        }
    ]
    ```

11. `'/usuarios/{:id_usuario}'` --> Consulta de usuario

    Se debe enviar un requerimiento `HTTP GET` a la URL `/usuarios/{:id_usuario}`.

    El parametro incluido en la URL es un identificador del usuario que se quiere consutlar

    La respuesta es un objeto `JSON` con la siguiente estructura:

        HTTP 200 OK

    ```JSON
    {
        "id": "1",
        "nombreUsuario": "mlopez",
        "contrasena": "bpm",
        "email": "mlopez@gmail.com",
        "dni": "38951674",
        "nombre": "maria",
        "apellido": "lopez"
    }
    ```

12. `'/usuarios'` --> Registrar usuario

    Se debe enviar un requerimiento `HTTP POST` a la URL `/usuarios`.

    La solicitud debe incluir en el `body` un objeto `JSON` en donde se indiquen los siguientes parametros: nombreUsuario, mail, contrasena, nombre, apellido, DNI

    Ejemplo:

    ```JSON
    {
      "nombreUsuario": "ortu.agustin",
      "mail": "ortu.agustin@gmail.com",
      "contrasena": "bpm",
      "nombre": "Agustin",
      "apellido": "Ortu",
      "DNI": "37058719"
    }
    ```
    Todos los parámetros serán validados:

    * Todos los campos son obligatorios
    * Se validará que el nombre de usuario no esté en uso

    Esto devuelve una respuesta en donde el `body` es un objeto `JSON` con la siguiente estructura:

        HTTP 200 OK

    ```JSON
    {
        "error_code": "integer",
        "message": "string"
    }
    ```
    Donde:

    * `message`: contiene un texto descriptivo del resultado de la operación
    * `error_code`: este campo unicamente se incluye  cuando la respuesta `HTTP` vuelve con un `Status Code 400 Bad Request`. Es un codigo de error cuyo significado puede consultarse en el endpoint `/error-code/{:id_error_code}`

13. `'/actualizar-tipo-incidente'` --> Actualizar tipo de incidente

    Se debe enviar un requerimiento `HTTP POST` a la URL `/actualizar-tipo-incidente`.

    La solicitud debe incluir en el `body` un objeto `JSON` en donde se indiquen los siguientes parametros: `id_incidente` e `id_tipo_incidente`

    Ejemplo:

    ```JSON
    {
      "id_incidente": "35",
      "id_tipo_incidente": "2"
    }
    ```
    Tambien es valido enviar el tipo de incidente por su nombre, en el parametro `tipo_incidente`

    Ejemplo:

    ```JSON
    {
      "id_incidente": "35",
      "tipo_incidente": "vehiculo"
    }
    ```

    La respuesta es el incidente en formato `JSON`. Ver `GET '/incidente/{:id_incidente}'`

14. `'/presupuestos/{:id_incidente}'` --> Registrar presupuesto

    Se debe enviar un requerimiento `HTTP POST` a la URL `/presupuestos/{:id_incidente}`

    El parametro incluido en la URL es el identificador del incidente al cual se le asocia el presupuesto.

    La solicitud debe incluir en el `body` un objeto `JSON` en donde se indiquen los siguientes parametros: `objetos` y `total_final`

    Ejemplo:

    ```JSON
    {
      "objetos": [
        {
          "nombre": "puerta",
          "cantidad": 1,
          "descripcion": "la fue abollada por el granizo",
          "precio": 1871.19,
          "total": 1871.19
        },
        {
          "nombre": "parabrisas",
          "cantidad": 2,
          "descripcion": "el vidrio fue estallado por el granizo",
          "precio": 2515.08,
          "total": 5030.16
        }
      ],
      "total_final": 6901.35
    }
    ```

    Todos los parámetros serán validados:

    * `objetos`: es un array con los objetos a indemnizar. Para cada elemento se debe consignar:
        * `nombre`: nombre del objeto
        * `cantidad`: cantidad de objetos requerida
        * `descripcion`: descripcion del incidente sobre el objeto
        * `precio`: number, es el precio unitario del objeto
        * `total`: number, el total por los objetos consignados
    * `total_final`: number, es el valor total del presupuesto

    Esto devuelve una respuesta en donde el `body` es un objeto `JSON` con la siguiente estructura:

        HTTP 200 OK

    ```JSON
    {
      "message": "string",
      "id_incidente": "integer",
      "id_presupuesto": "integer"
    }
    ```
    Donde:

    * `message`: contiene un texto descriptivo del resultado de la operación
    * `id_incidente`: es el identificador del incidente al cual se asoció el presupuesto
    * `id_presupuesto`: contiene un `id` que es el identificador asignado por el sistema para el presupuesto creado
    * `error_code`: este campo unicamente se incluye  cuando la respuesta `HTTP` vuelve con un `Status Code 400 Bad Request`. Es un codigo de error cuyo significado puede consultarse en el endpoint `/error-code/{:id_error_code}`

    Ejemplo:

        HTTP 200 OK

    ```JSON
    {
      "message": "Se creó el presupuesto 7 para el expediente # 5",
      "id_incidente": "5",
      "id_presupuesto": "7"
    }
    ```

15. `'/actualizar-estado-incidente'` --> Actualizar estado de incidente

    Se debe enviar un requerimiento `HTTP POST` a la URL `/actualizar-estado-incidente`.

    La solicitud debe incluir en el `body` un objeto `JSON` en donde se indiquen los siguientes parametros: `id_incidente` e `id_estado_incidente`

    Ejemplo:

    ```JSON
    {
      "id_incidente": "35",
      "id_estado_incidente": "1"
    }
    ```
    Tambien es valido enviar el estado de incidente por su nombre, en el parametro `estado`

    Ejemplo:

    ```JSON
    {
      "id_incidente": "35",
      "estado": "pendiente"
    }
    ```

    La respuesta es el incidente en formato `JSON`. Ver `GET '/incidente/{:id_incidente}'`

16. `'/error-code/{:id_error_code}'` --> Consulta de código de error

    Se debe enviar un requerimiento `HTTP GET` a la URL `/error-code/{:id_error_code}`.

    El parametro incluido en la URL es un identificador del código de error que se quiere consutlar

    La respuesta es un objeto `JSON` con la siguiente estructura:

        HTTP 200 OK

    ```JSON
    {
      "id": "1",
      "description": "El turno solicitado ya se encuentra ocupado"
    }
    ```

## Instalación

1. Se agrega un `Virtual-Host` al servidor de Apache2, en este ejemplo la API se registra en el dominio `api-incidentes.com`

    Crear el archivo `/etc/apache2/sites-available/api-incidentes.com.conf` con el contenido:

    ```xml
    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName api-incidentes.com
        ServerAlias www.api-incidentes.com
        DocumentRoot /var/www/html/api-incidentes.com

        <Directory /var/www/html/api-incidentes.com/>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>
    </VirtualHost>
    ```

  >Nota: El directorio `/var/www/html/api-incidentes.com` debe existir

2. Ejecutar los comandos en una terminal (los dos primeros pueden no ser necesarios si ya se ejecutaron alguna vez):

    ```
    sudo a2enmod rewrite
    sudo a2dissite 000-default.conf
    sudo a2ensite api-incidentes.com
    ```

3. Agregar en hosts: `/etc/hosts`

    ```
    127.0.0.1 api-incidentes.com
    ```

4. Luego reiniciar el servicio de Apache

    ```
    systemctl restart apache2
    ```
