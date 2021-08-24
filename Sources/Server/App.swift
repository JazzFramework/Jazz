import Foundation;

import Codec;
import DependencyInjection;

public class App {
    private let _httpProcessor: HttpProcessor;
    private let _serviceProviderBuilder: ServiceProviderBuilder;

    private var _queuedLogic: [(HttpProcessor, ServiceProvider) throws -> Void];
    private var _queuedBackgroundProcesses: [(ServiceProvider) throws -> Void];

    internal init(with httpProcessor: HttpProcessor) {
        _httpProcessor = httpProcessor;
        _serviceProviderBuilder = ServiceProviderBuilder();

        _queuedLogic = [];
        _queuedBackgroundProcesses = [];
    }

    public func WireUp<T>(singleton: @escaping (ServiceProvider) throws -> T) throws -> App {
        _ = try _serviceProviderBuilder.Register(singleton);

        return self;
    }

    public func WireUp<TController: Controller>(controller: @escaping (ServiceProvider) throws -> TController) throws -> App {
        _ = try _serviceProviderBuilder.Register(controller);

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

    public func WireUp<TErrorTranslator: ErrorTranslator>(errorTranslator: @escaping (ServiceProvider) throws -> TErrorTranslator) throws -> App {
        _ = try _serviceProviderBuilder.Register(errorTranslator);

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

    public func WireUp<TMiddleware: Middleware>(middleware: @escaping (ServiceProvider) throws -> TMiddleware) throws -> App {
        _ = try _serviceProviderBuilder.Register(middleware);

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

    public func WireUp<TTranscoder: Transcoder>(transcoder: @escaping (ServiceProvider) throws -> TTranscoder) throws -> App {
        _ = try _serviceProviderBuilder.Register(transcoder);

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

    public func WireUp<TBackgroundProcess: BackgroundProcess>(backgroundProcess: @escaping (ServiceProvider) throws -> TBackgroundProcess) throws -> App {
        _ = try _serviceProviderBuilder.Register(backgroundProcess);

        _queuedBackgroundProcesses.append(
            {
                serviceProvider in

                if let backgroundProcess: TBackgroundProcess = try serviceProvider.Get() {
                    DispatchQueue.global(qos: .userInitiated).async {
                        backgroundProcess.Logic();
                    }
                }
            }
        );

        return self;
    }

    public func Run() throws {
        let serviceProvider: ServiceProvider = _serviceProviderBuilder.Build();

        for logic in _queuedLogic {
            try logic(_httpProcessor, serviceProvider);
        }

        for logic in _queuedBackgroundProcesses {
            try logic(serviceProvider);
        }

        try _httpProcessor.Start();
    }
}