import Foundation;

import Codec;
import DependencyInjection;

public class ServerApp: App {
    private let _httpProcessor: HttpProcessor;

    private var _queuedLogic: [(HttpProcessor, ServiceProvider) throws -> Void];
    private var _queuedBackgroundProcesses: [(ServiceProvider) throws -> Void];

    internal init(with httpProcessor: HttpProcessor) {
        _httpProcessor = httpProcessor;

        _queuedLogic = [];
        _queuedBackgroundProcesses = [];

        super.init();
    }

    public func WireUp<TController: Controller>(controller: @escaping (ServiceProvider) throws -> TController) throws -> ServerApp {
        _ = try WireUp(singleton: controller);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let controller: TController = try serviceProvider.Get() {
                    _ = httpProcessor.WireUp(controller: controller);
                }
            }
        );

        return self;
    }

    public func WireUp<TErrorTranslator: ErrorTranslator>(errorTranslator: @escaping (ServiceProvider) throws -> TErrorTranslator) throws -> ServerApp {
        _ = try WireUp(singleton: errorTranslator);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let errorTranslator: TErrorTranslator = try serviceProvider.Get() {
                    _ = httpProcessor.WireUp(errorTranslator: errorTranslator);
                }
            }
        );

        return self;
    }

    public func WireUp<TMiddleware: Middleware>(middleware: @escaping (ServiceProvider) throws -> TMiddleware) throws -> ServerApp {
        _ = try WireUp(singleton: middleware);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let middleware: TMiddleware = try serviceProvider.Get() {
                    _ = httpProcessor.WireUp(middleware: middleware);
                }
            }
        );

        return self;
    }

    public override func WireUp<TTranscoder: Transcoder>(transcoder: @escaping (ServiceProvider) throws -> TTranscoder) throws -> ServerApp {
        _ = try super.WireUp(transcoder: transcoder);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let transcoder: TTranscoder = try serviceProvider.Get() {
                    _ = httpProcessor.WireUp(transcoder: transcoder);
                }
            }
        );

        return self;
    }

    public func WireUp<TBackgroundProcess: BackgroundProcess>(backgroundProcess: @escaping (ServiceProvider) throws -> TBackgroundProcess) throws -> ServerApp {
        _ = try WireUp(singleton: backgroundProcess);

        _queuedBackgroundProcesses.append(
            {
                serviceProvider in

                if let backgroundProcess: TBackgroundProcess = try serviceProvider.Get() {
                    DispatchQueue.global(qos: .background).async {
                        backgroundProcess.Logic();
                    }
                }
            }
        );

        return self;
    }

    public override func Run() throws {
        let serviceProvider: ServiceProvider = GetServiceProviderBuilder().Build();

        for logic in _queuedLogic {
            try logic(_httpProcessor, serviceProvider);
        }

        for logic in _queuedBackgroundProcesses {
            try logic(serviceProvider);
        }

        try _httpProcessor.Start();
    }
}