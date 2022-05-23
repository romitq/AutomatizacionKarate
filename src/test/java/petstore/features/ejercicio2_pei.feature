Feature: Ejercicio PEI GET

  Scenario Outline: Consultar mascotas creadas
    Given url 'https://petstore.swagger.io/v2/pet/<id>'
    * def res_crear_mascota = read('../response/crear_mascota.json')
    When method GET
    Then status 200
    And match response == res_crear_mascota

    Examples:
      | id |
      | 12 |
