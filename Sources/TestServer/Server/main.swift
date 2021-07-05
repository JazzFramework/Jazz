import Foundation;

import DataAccess;
import DataAccessInMemory;
import DependencyInjection;

import Server;
import ServerNio;

try AppBuilder()
    .With(httpProcessor: NioHttpProcessor())
    .Build()

        .WireUp(singleton: { _ in return InMemoryStorageHandler<Weather>() as StorageHandler<Weather>; })
        .WireUp(singleton: { sp in return WeatherRepository(with: try sp.FetchType()); })

        .WireUp(singleton: { sp in return CreateWeatherActionImpl(with: try sp.FetchType()) as CreateWeatherAction; })
        .WireUp(singleton: { sp in return DeleteWeatherActionImpl(with: try sp.FetchType()) as DeleteWeatherAction; })
        .WireUp(singleton: { sp in return GetWeatherActionImpl(with: try sp.FetchType()) as GetWeatherAction; })
        .WireUp(singleton: { sp in return GetWeathersActionImpl(with: try sp.FetchType()) as GetWeathersAction; })
        .WireUp(singleton: { sp in return UpdateWeatherActionImpl(with: try sp.FetchType()) as UpdateWeatherAction; })

        .WireUp(controller: { sp in return CreateWeatherController(with: try sp.FetchType()); })
        .WireUp(controller: { sp in return DeleteWeatherController(with: try sp.FetchType()); })
        .WireUp(controller: { sp in return GetWeatherCollectionController(with: try sp.FetchType()); })
        .WireUp(controller: { sp in return GetWeatherController(with: try sp.FetchType()); })
        .WireUp(controller: { sp in return UpdateWeatherController(with: try sp.FetchType()); })

        .WireUp(transcoder: { _ in return ApiErrorV1JsonCodec(); })
        .WireUp(transcoder: { _ in return WeatherV1JsonCodec(); })

        .WireUp(errorTranslator: { _ in return ImpossibleWeatherErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return NotAuthorizedErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return NotAcceptableErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return UnsupportedMediaTypeErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return MissingBodyErrorTranslator(); })
        .WireUp(errorTranslator: { _ in return LastResortErrorTranslator(); })

        .WireUp(middleware: { _ in return AuthMiddleware(); })
        .WireUp(middleware: { _ in return RequestLoggingMiddleware(); })
        .WireUp(middleware: { _ in return MetricsMiddleware(); })

        .Run();