import Foundation;

import Server;
import ServerNio;

try AppBuilder()
    .With(httpProcessor: NioHttpProcessor())
    .Build()

        .WireUp(controller: { _ in return Weather3Controller(); })
        .WireUp(controller: { _ in return Weather2Controller(with: GetWeatherActionImpl()); })
        .WireUp(controller: { _ in return WeatherController(); })

        .WireUp(transcoder: { _ in return ApiErrorV1JsonCodec(); })
        .WireUp(transcoder: { _ in return WeatherV1JsonCodec(); })

        .WireUp(errorTranslator: { _ in return ImpossibleWeatherErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return NotAcceptableErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return UnsupportedMediaTypeErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return LastResortErrorTranslator(); })

        .WireUp(middleware: { _ in return LoggingMiddleware3(); })
        .WireUp(middleware: { _ in return LoggingMiddleware2(); })
        .WireUp(middleware: { _ in return LoggingMiddleware1(); })

        .Run();