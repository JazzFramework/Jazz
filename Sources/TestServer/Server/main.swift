import Server;
import ServerNio;

try AppRunner(
    withApp:
        AppBuilder()
            .With(httpProcessor: NioHttpProcessor())
            .Build(),
    withInitializers: [
        ActionsInitializer(),
        CodecsInitializer(),
        ControllersInitializer(),
        DataAccessLayerInitializer(),
        ErrorTranslatorsInitializer(),
        MiddlewaresInitializer()
    ]
)
    .Run();