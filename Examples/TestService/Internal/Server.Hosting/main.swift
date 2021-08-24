import Server;
import ServerNio;

import ExampleThirdPartyServerAuthentication;
import ExampleThirdPartyServerRequestLogging;

import ExampleServerActions;
import ExampleServerHelloWorldBackgroundProcess;
import ExampleServerDataAccess;

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
        ActionsInitializer(),
        BackgroundProcessInitializer(),
        WeatherStorageHandlerInitializer(),

        //Initializers defined in this project
        CodecsInitializer(),
        ControllersInitializer(),
        DataAccessLayerInitializer(),
        ErrorTranslatorsInitializer(),
        MiddlewaresInitializer()
    ]
)
    .Run();