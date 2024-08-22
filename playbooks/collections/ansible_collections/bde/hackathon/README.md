# Collection bde.hackathon
Este repositorio contiene la collection bde.hackathon

## Propósito
La colección se ha creado para ser empleada como parte del Reto #2. En concreto, se hará uso del rol currency.

Toda la información relativa al rol puede consultarse en la propia documentación del rol.

## Versión Ansible compatible
Esta collection ha sido probada para la versión Ansible >=2.15.10.

## Requisitos externos
El rol currency requiere de la colección community.general ya que se está usando el filtro json_query.

## Roles incluidos

| Rol |  Descripción  |
| :----------- | :------------ |
| **currency** | Este rol, dada una divisa, es capaz de consultar el tipo de cambio proporcionado por la API Rest simulada del BCE y de actualizar la web simulada del BdE |

## Variables
Las variables se detallan dentro de cada rol. No hay variables globales definidas.

## Actualizaciones y versiones (changelog)
Versión 1.0.0:
- Primera versión funcional

## Información del autor
BDE Automation 360
