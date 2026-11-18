@ignore
Feature: Cierre de sesion y validacion de bloqueo de acceso

  Background:
    * url baseUrl

  Scenario: Cerrar sesion y verificar rechazo sin token
    # 1. Confirmamos que el token recibido estaba activo
    Given path '/auth/me'
    And header Authorization = 'Bearer ' + tokenActivo
    When method get
    Then status 200

    # 2. Invalidamos el token en memoria
    * def tokenActivo = null

    # 3. Validamos que la ruta rechaza la peticion sin token valido
    Given path '/auth/me'
    When method get
    Then status 401
    * assert response.message == 'Token Expired' || response.message == 'Invalid/Expired Token!' || response.message == 'Access Token is required'