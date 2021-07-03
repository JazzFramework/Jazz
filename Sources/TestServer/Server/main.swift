import Foundation;

import Server;
import ServerNio;

try AppBuilder()
    .With(httpProcessor: NioHttpProcessor())
    .Build()
        .WireUp(controller: {_ in return Weather3Controller(); })
        .WireUp(controller: {_ in return Weather2Controller(with: GetWeatherActionImpl()); })
        .WireUp(controller: {_ in return WeatherController(); })

        .WireUp(encoder: {_ in return ApiErrorV1JsonCodec(); })
        .WireUp(decoder: {_ in return ApiErrorV1JsonCodec(); })
        .WireUp(encoder: {_ in return WeatherV1JsonCodec(); })
        .WireUp(decoder: {_ in return WeatherV1JsonCodec(); })

        .WireUp(errorTranslator: {_ in return ImpossibleWeatherErrorTranslator(); })
        .WireUp(errorTranslator: {_ in return NotAcceptableErrorTranslator(); })
        .WireUp(errorTranslator: {_ in return UnsupportedMediaTypeErrorTranslator(); })
        .WireUp(errorTranslator: {_ in return LastResortErrorTranslator(); })

        .Run();