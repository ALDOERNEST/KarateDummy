function fn() {
    var env = karate.env || 'qa'; // Si no le pasas entorno, por defecto toma 'qa'

    var config = {
        env: env,
        baseUrl: 'https://dummyjson.com'
    };

    // Configuraciones globales de tiempo de espera para las peticiones HTTP
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);

    return config;
}