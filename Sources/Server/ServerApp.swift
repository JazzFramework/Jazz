import Foundation;

import Codec;
import DependencyInjection;

public class ServerApp: App {
    private let _httpProcessor: HttpProcessor;

    private var _queuedLogic: [(HttpProcessor, ServiceProvider) async throws -> Void];
    private var _queuedBackgroundProcesses: [(ServiceProvider) async throws -> Void];

    internal init(with httpProcessor: HttpProcessor) {
        _httpProcessor = httpProcessor;

        _queuedLogic = [];
        _queuedBackgroundProcesses = [];

        super.init();
    }

    public func WireUp<TController: Controller>(controller: @escaping (ServiceProvider) async throws -> TController) throws -> ServerApp {
        _ = try WireUp(singleton: controller);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let controller: TController = try await serviceProvider.Get() {
                    _ = httpProcessor.WireUp(controller: controller);
                }
            }
        );

        return self;
    }

    public func WireUp<TErrorTranslator: ErrorTranslator>(errorTranslator: @escaping (ServiceProvider) async throws -> TErrorTranslator) throws -> ServerApp {
        _ = try WireUp(singleton: errorTranslator);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let errorTranslator: TErrorTranslator = try await serviceProvider.Get() {
                    _ = httpProcessor.WireUp(errorTranslator: errorTranslator);
                }
            }
        );

        return self;
    }

    public func WireUp<TMiddleware: Middleware>(middleware: @escaping (ServiceProvider) async throws -> TMiddleware) throws -> ServerApp {
        _ = try WireUp(singleton: middleware);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let middleware: TMiddleware = try await serviceProvider.Get() {
                    _ = httpProcessor.WireUp(middleware: middleware);
                }
            }
        );

        return self;
    }

    public override func WireUp<TTranscoder: Transcoder>(transcoder: @escaping (ServiceProvider) async throws -> TTranscoder) throws -> ServerApp {
        _ = try super.WireUp(transcoder: transcoder);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let transcoder: TTranscoder = try await serviceProvider.Get() {
                    _ = httpProcessor.WireUp(transcoder: transcoder);
                }
            }
        );

        return self;
    }

    public func WireUp<TBackgroundProcess: BackgroundProcess>(backgroundProcess: @escaping (ServiceProvider) async throws -> TBackgroundProcess) throws -> ServerApp {
        _ = try WireUp(singleton: backgroundProcess);

        _queuedBackgroundProcesses.append(
            {
                serviceProvider in

                if let backgroundProcess: TBackgroundProcess = try await serviceProvider.Get() {
                    DispatchQueue.global(qos: .background).async {
                        backgroundProcess.Logic();
                    }
                }
            }
        );

        return self;
    }

    public override func Run() async throws {
        let serviceProvider: ServiceProvider = GetServiceProviderBuilder().Build();

        for logic in _queuedLogic {
            try await logic(_httpProcessor, serviceProvider);
        }

        for logic in _queuedBackgroundProcesses {
            try await logic(serviceProvider);
        }

         try await _httpProcessor.Start();
    }
}