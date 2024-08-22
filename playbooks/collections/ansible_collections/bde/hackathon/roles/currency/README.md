# Rol currency
Este rol, dada una divisa, es capaz de consultar el tipo de cambio en el BCE y de actualizar la web simulada del BdE según las siguientes condiciones:

- Si el tipo de cambio obtenido del BCE no excede el límite fijado por BdE, se usa el valor del BCE.
- Si el tipo de cambio obtenido del BCE excede el límite fijado por BdE, se usa el valor límite.
- Si el tipo de cambio del BCE coincide con el valor publicado por BdE, se omite la petición PUT para actualizar la web del BdE.

## Descripción
El rol realiza, según las variables de entrada proporcionadas, las siguientes acciones secuenciales:

- Consulta a la API Rest simulada del BCE para obtener el tipo de cambio más reciente (dada una divisa).
- Consulta a la API Rest simulada del BdE para obtener el valor actual publicado (dada una divisa).
- Debug de ambas respuestas (para un verbosity de 3, esto es, solo cuando se indique -vvv).
- Se fijan las variables bce_value, bde_limit y bde_value.
- Se fija la variable new_rate_value teniendo en cuenta la lógica descrita anteriormente.
- Se actualiza la web de BdE vía petición PUT a la API Rest.

## Versión Ansible compatible
Este rol ha sido probado para la versión Ansible >=2.15.10.

## Requisitos externos
Este rol requiere de la colección community.general ya que se está usando el filtro json_query.

## Variables

**Variables de entrada**

Estas variables deben proporcionarse al rol desde el playbook que lo incluya.

| Variable |  Descripción  |Tipo |Obligatoria/Opcional |Valor por defecto |Rango de valores |
| :----------- | :------------ | :------------ | :------------ | :------------ | :------------ |
| **loop_currency** | Divisa a tratar | String | Obligatoria | N/A | N/A |
| **bde_endpoint** | Endpoint de la API Rest de BdE | String | Opcional | http://localhost:3000/app_rates | N/A |
| **currency_bce_endpoint** | Endpoint de la API Rest del BCE | String | Obligatoria | N/A | N/A |
| **currency_get_limit_json_filter** | Filtro json a aplicar para obtener el límite dado una divisa | String | Obligatoria | N/A | N/A |
| **currency_get_value_json_filter** | Filtro json a aplicar para obtener el valor dado una divisa | String | Obligatoria | N/A | N/A |

Tal y como se comenta en la documentación del reto, los endpoints simulados definidos son:

**Para BCE**
- GET http://localhost:3000/bce_rates/{{ loop_currency }} => obtiene el valor del tipo de cambio para la divisa parametrizada.

**Para BdE**
- GET http://localhost:3000/app_rates => obtiene una lista con todas las divisas, en formato json. Para cada divisa, se devuelve el valor publicado en la web y el límite establecido.

- PUT http://localhost:3000/app_rates => método para actualizar el dato que se visualiza en la web de BdE. Esta petición debe incluir body en formato json que incluya los campos "currency" y "value".

**Variables de salida**

N/A

# Guía de uso
No se proporcionan ejemplos de uso, para no dar pistas :)

No obstante, puede ser interesante ejecutar el rol con un nivel de verbosity igual a 3, ya que se imprimirán las respuestas json que devuelven los diferentes endpoints.

## Actualizaciones (Changelog)
Versión 1.0.0:
- Primera versión funcional

## Información del autor
BDE Automation 360
