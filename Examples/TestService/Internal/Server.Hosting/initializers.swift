import Server;

import ExampleThirdPartyServerAuthentication;
import ExampleThirdPartyServerRequestLogging;

import ExampleClient;
import ExampleServerDataAccessInMemory;
import ExampleServerActionsCreateWeather;
import ExampleServerActionsDeleteWeather;
import ExampleServerActionsGetWeather;
import ExampleServerActionsGetWeathers;
import ExampleServerActionsUpdateWeather;
import ExampleServerHelloWorldBackgroundProcess;
import ExampleServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator;
import ExampleServerHostingEndpoints;

let initializers: [Initializer] = [
    //Initializers from "Third Party" code.
    AuthenticationInitializer(),
    RequestLoggingInitializer(),

    //Initializers from other internal projects.
    WeatherClientInitializer(),

    InMemoryWeatherRepositoryInitializer(),

    CreateWeatherActionInitializer(),
    DeleteWeatherActionInitializer(),
    GetWeatherActionInitializer(),
    GetWeathersActionInitializer(),
    UpdateWeatherActionInitializer(),

    HelloWorldBackgroundProcessInitializer(),

    WeatherInvalidTempErrorTranslatorInitializer(),

    EndpointsInitializer()
];