import Foundation;

import WindmillCodec;
import WindmillCore;
import WindmillDependencyInjection;

public class ServerApp: App {
    private let _httpProcessor: HttpProcessor;

    private var _queuedLogic: [(HttpProcessor, ServiceProvider) async throws -> Void];

    internal init(with httpProcessor: HttpProcessor) {
        _httpProcessor = httpProcessor;

        _queuedLogic = [];

        super.init();
    }

    public func wireUp<TController: Controller>(
        controller: @escaping (ServiceProvider) async throws -> TController
    ) throws -> ServerApp {
        _ = try wireUp(singleton: controller);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                let controller: TController = try await serviceProvider.fetchType();

                _ = httpProcessor.wireUp(controller: controller);
            }
        );

        return self;
    }

    public func wireUp<TErrorTranslator: ErrorTranslator>(
        errorTranslator: @escaping (ServiceProvider) async throws -> TErrorTranslator
    ) throws -> ServerApp {
        _ = try wireUp(singleton: errorTranslator);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                let errorTranslator: TErrorTranslator = try await serviceProvider.fetchType();

                _ = httpProcessor.wireUp(errorTranslator: errorTranslator);
            }
        );

        return self;
    }

    public func wireUp<TMiddleware: Middleware>(
        middleware: @escaping (ServiceProvider) async throws -> TMiddleware
    ) throws -> ServerApp {
        _ = try wireUp(singleton: middleware);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                let middleware: TMiddleware = try await serviceProvider.fetchType();

                _ = httpProcessor.wireUp(middleware: middleware);
            }
        );

        return self;
    }

    public func wireUp<TTranscoder: Transcoder>(
        transcoder: @escaping (ServiceProvider) async throws -> TTranscoder
    ) throws -> ServerApp {
        _ = try super.wireUp(singleton: transcoder);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                let transcoder: TTranscoder = try await serviceProvider.fetchType();

                _ = httpProcessor.wireUp(transcoder: transcoder);
            }
        );

        return self;
    }

    public override final func wireUp<T>(singleton: @escaping (ServiceProvider) async throws -> T) throws -> ServerApp {
        _ = try super.wireUp(singleton: singleton);

        return self;
    }

    public override final func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> ServerApp {
        _ = try super.wireUp(backgroundProcess: backgroundProcess);

        return self;
    }

    public override final func initialize(serviceProvider: ServiceProvider) async throws {
        try await super.initialize(serviceProvider: serviceProvider);

        for logic in _queuedLogic {
            try await logic(_httpProcessor, serviceProvider);
        }

         try await _httpProcessor.start();
    }
}