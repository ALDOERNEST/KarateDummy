@ignore
Feature: Autenticacion reutilizable en DummyJSON

  Background:
    * url baseUrl

  Scenario: Obtener token JWT valido
    * def usuario = karate.get('username', 'emilys')
    * def clave = karate.get('password', 'emilyspass')

    Given path '/auth/login'
    And request { username: '#(usuario)', password: '#(clave)', expiresInMins: 30 }
    When method post
    Then status 200
    And match response.accessToken == '#string'

    # Variables expuestas al feature principal que haga el 'call'
    * def authToken = response.accessToken
    * def userId = response.id