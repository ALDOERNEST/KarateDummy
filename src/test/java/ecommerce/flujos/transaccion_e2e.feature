Feature: Flujo E2E de Compra con Autenticacion Modular

  Background:
    * url baseUrl

  @smoke
  Scenario: Validacion rapida de autenticacion (Smoke Test)
    * def sesion = call read('classpath:ecommerce/comunes/Login.feature')
    * match sesion.authToken == '#string'
    * print 'Token generado correctamente para el usuario ID:', sesion.userId

  @e2e @transaccion
  Scenario: Flujo completo - Login, Creacion de Carrito y Logout
    # 1. Llamada al login reutilizable
    * def sesion = call read('classpath:ecommerce/comunes/Login.feature') { username: 'emilys', password: 'emilyspass' }
    * def token = sesion.authToken
    * def idUsuario = sesion.userId

    # 2. Transaccion de negocio (Agregar productos al carrito)
    Given path '/carts/add'
    And header Authorization = 'Bearer ' + token
    And request
      """
      {
        "userId": #(idUsuario),
        "products": [
          { "id": 144, "quantity": 2 },
          { "id": 98, "quantity": 1 }
        ]
      }
      """
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.total == '#number'
    * assert response.total > 0
    And match response.totalProducts == 2

    # 3. Llamada al logout reutilizable pasando el token activo
    * call read('classpath:ecommerce/comunes/logout.feature') { tokenActivo: '#(token)' }