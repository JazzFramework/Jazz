import Server;
import ServerNio;

import ExampleThirdPartyServerAuthentication;
import ExampleThirdPartyServerRequestLogging;

import ExampleServerActions;
import ExampleServerDataAccess;

try AppRunner(
    withApp:
        AppBuilder()
            .With(httpProcessor: HummingbirdHttpProcessor())
            .Build(),
    withInitializers: [
        AuthenticationInitializer(),
        RequestLoggingInitializer(),

        ActionsInitializer(),
        CodecsInitializer(),
        ControllersInitializer(),
        DataAccessLayerInitializer(),
        ErrorTranslatorsInitializer(),
        MiddlewaresInitializer(),
        WeatherStorageHandlerInitializer()
    ]
)
    .Run();