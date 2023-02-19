import Foundation;

import JazzCodec;
import JazzConfiguration;
import JazzCore;
import JazzDependencyInjection;

public final class ServerApp: App {
    internal override init() {
        super.init();
    }

    public final func wireUp<TController: Controller>(
        controller: @escaping (Configuration, ServiceProvider) async throws -> TController
    ) throws -> ServerApp {
        _ = try wireUp(singleton: { configuration, sp in return try await controller(configuration, sp) as Controller; });

        return self;
    }

    public final func wireUp(assetControllers: [String:String]) throws -> ServerApp {
        for (path, local) in assetControllers {
            _ = try wireUp(controller: { configuration, sp in
                return AssetServerController(path: path, local: local, bundle: try await sp.fetchType());
            });
        }

        return self;
    }

    public final func wireUp(fileControllers: [String:String]) throws -> ServerApp {
        for (path, local) in fileControllers {
            _ = try wireUp(controller: { configuration, sp in return FileServerController(path: path, local: local); });
        }

        return self;
    }

    public final func wireUp<TErrorTranslator: ErrorTranslator>(
        errorTranslator: @escaping (Configuration, ServiceProvider) async throws -> TErrorTranslator
    ) throws -> ServerApp {
        _ = try wireUp(singleton: { configuration, sp in return try await errorTranslator(configuration, sp) as ErrorTranslator; });

        return self;
    }

    public final func wireUp<TMiddleware: Middleware>(
        middleware: @escaping (Configuration, ServiceProvider) async throws -> TMiddleware
    ) throws -> ServerApp {
        _ = try wireUp(singleton: { configuration, sp in return try await middleware(configuration, sp) as Middleware; });

        return self;
    }

    public final func wireUp<TTranscoder: Transcoder>(
        transcoder: @escaping (Configuration, ServiceProvider) async throws -> TTranscoder
    ) throws -> ServerApp {
        _ = try wireUp(singleton: { configuration, sp in return try await transcoder(configuration, sp) as Transcoder; });

        return self;
    }

    public override final func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (Configuration, ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> ServerApp {
        _ = try wireUp(singleton: { configuration, sp in return try await backgroundProcess(configuration, sp) as BackgroundProcess; });

        return self;
    }

    public override final func wireUp<T>(singleton: @escaping (Configuration, ServiceProvider) async throws -> T) throws -> ServerApp {
        _ = try super.wireUp(singleton: singleton);

        return self;
    }

    public override final func initialize(configuration: Configuration, serviceProvider: ServiceProvider) async throws {
        try await super.initialize(configuration: configuration, serviceProvider: serviceProvider);

        let httpProcessor: HttpProcessor = try await serviceProvider.fetchType();

        try await httpProcessor.start();
    }
}