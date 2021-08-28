import Foundation;

import Configuration;
import Server;
import ServerNio;

import ExampleThirdPartyServerAuthentication;
import ExampleThirdPartyServerRequestLogging;

import ExampleServerDataAccessInMemory;
import ExampleServerActionsCreateWeather;
import ExampleServerActionsDeleteWeather;
import ExampleServerActionsGetWeather;
import ExampleServerActionsGetWeathers;
import ExampleServerActionsUpdateWeather;
import ExampleServerHelloWorldBackgroundProcess;
import ExampleServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator;

try AppRunner(
    withApp:
        AppBuilder()
            .With(httpProcessor: HummingbirdHttpProcessor())
            .Build(),
    withInitializers: [
        //Initializers from "Third Party" code.
        AuthenticationInitializer(),
        RequestLoggingInitializer(),

        //Initializers from other internal projects.
        InMemoryWeatherRepositoryInitializer(),

        CreateWeatherActionInitializer(),
        DeleteWeatherActionInitializer(),
        GetWeatherActionInitializer(),
        GetWeathersActionInitializer(),
        UpdateWeatherActionInitializer(),

        HelloWorldBackgroundProcessInitializer(),

        WeatherInvalidTempErrorTranslatorInitializer(),

        //Initializers defined in this project
        CodecsInitializer(),
        ConfigurationInitializer(),
        ControllersInitializer(),
        MiddlewaresInitializer()
    ],
    withConfiguration:
        ConfigurationBuilder()
            .With(bundle: Bundle.module)
)
    .Run();