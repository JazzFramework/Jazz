import Server;
import ServerNio;

import ExampleServerAuthentication;

try AppRunner(
    withApp:
        AppBuilder()
            .With(httpProcessor: HummingbirdHttpProcessor())
            .Build(),
    withInitializers: [
        AuthenticationInitializer(),
        ActionsInitializer(),
        CodecsInitializer(),
        ControllersInitializer(),
        DataAccessLayerInitializer(),
        ErrorTranslatorsInitializer(),
        MiddlewaresInitializer()
    ]
)
    .Run();