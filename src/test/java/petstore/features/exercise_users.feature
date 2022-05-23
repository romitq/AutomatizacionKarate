Feature: Ejercicio de consultas API Users

  Background: Precondiciones
    * def req_crear_usuario = read('../request/crear_usuario.json')
    * def res_estructura_usuario = read('../response/estructura_usuario.json')
    * def res_consulta_usuario = read('../response/consulta_usuario.json')
    * url 'https://petstore.swagger.io/v2/user'

  Scenario Outline: Crear usuario
    * set req_crear_usuario.id = <id>
    * set req_crear_usuario.username = <username>
    * set req_crear_usuario.firstName = <firstName>
    * set req_crear_usuario.lastName = <lastName>
    * set req_crear_usuario.email = <email>
    * set req_crear_usuario.password = <password>
    And request req_crear_usuario
    When method POST
    Then status 200
    And match response == res_estructura_usuario

    Examples:
    | id | username   | firstName  | lastName   | email              | password     |
    | 25 | "qa"       | "Romina"   | "Torres"   | "correo@gmail.com" | "contraseña" |

Scenario Outline: Consultar usuario
  Given path <username>
  When method GET
  Then status 200
  And match response == res_consulta_usuario

  Examples:
  | username  |
  | "qa"      |

Scenario Outline: Actualizar usuario - cambio de contraseña
  Given path <user>
  * set req_crear_usuario.id = <id>
  * set req_crear_usuario.username = <username>
  * set req_crear_usuario.firstName = <firstName>
  * set req_crear_usuario.lastName = <lastName>
  * set req_crear_usuario.email = <email>
  * set req_crear_usuario.password = <password>
  And request req_crear_usuario
  When method PUT
  Then status 200
  And match response == res_estructura_usuario

  Examples:
    | user | id | username   | firstName  | lastName   | email              | password |
    | "qa" | 25 | "qa"       | "Romina"   | "Torres"   | "correo@gmail.com" | "123"    |

  Scenario Outline: Actualizar usuario - prueba
    Given path <user>
    * set req_crear_usuario.id = <id>
    * set req_crear_usuario.username = <username>
    * set req_crear_usuario.password = <password>
    And request req_crear_usuario
    When method PUT
    Then status 200
    And match response == res_estructura_usuario

    Examples:
      | user | id  | username | password |
      | "qa" | 25  | "qa"     | "123"    |

