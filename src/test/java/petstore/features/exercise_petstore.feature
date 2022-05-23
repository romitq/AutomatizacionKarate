Feature: Ejercicio de consultas API Petstore

  Background: Precondiciones
    * def req_crear_mascota = read('../request/crear_mascota.json')
    * def res_crear_mascota = read('../response/crear_mascota.json')
    * def res_eliminar_mascota = read('../response/eliminar_mascota.json')
    * url 'https://petstore.swagger.io/v2/pet'

  Scenario Outline: Crear mascota Outline
    * set req_crear_mascota.id = <id>
    * set req_crear_mascota.name = <name>
    And request req_crear_mascota
    When method POST
    Then status 200
    And match response == res_crear_mascota
    And match response.id == <id_esperado>
    Examples:
      | id | id_esperado | name  |
      | 12 | 12          | "cat" |

  Scenario Outline: Consultar mascota creada
    Given path <id>
    When method GET
    Then status 200
    And match response == res_crear_mascota
    Examples:
      | id |
      | 12 |

  Scenario Outline: Actualizar una mascota
    * set req_crear_mascota.id = <id>
    * set req_crear_mascota.category = <category>
    And request req_crear_mascota
    When method PUT
    Then status 200
    And match response == res_crear_mascota
    Examples:
    | id |  category             |
    | 12 | {id:12, name: "Koko"} |

  Scenario Outline: Eliminar una mascota
    Given path <id>
    When method DELETE
    Then status 200
    And match response == res_eliminar_mascota
    Examples:
    | id |
    | 12 |

  Scenario Outline: Consultar mascota eliminada
    Given path <id>
    When method GET
    Then status 404
    And match response == res_eliminar_mascota
    Examples:
    | id |
    | 12 |







