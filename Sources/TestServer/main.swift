import Foundation;

import Server;
import ServerNio;

try AppBuilder()
    .With(httpProcessor: NioHttpProcessor())
    .Build()
        .WireUp(controller: {_ in return WeatherController(); })
        .Run();

print("Hello Swift");