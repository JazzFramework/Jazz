import Foundation;

import Configuration;
import Server;
import ServerNio;

try AppRunner(
    withApp:
        try AppBuilder()
            .With(httpProcessor: HummingbirdHttpProcessor())
            .Build(),
    withInitializers: initializers,
    withConfiguration: 
        ConfigurationBuilder()
            .With(bundle: Bundle.module)
)
    .Run();