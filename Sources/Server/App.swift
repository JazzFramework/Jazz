import Codec;
import DependencyInjection;

public class App {
    private let _httpProcessor: HttpProcessor;
    private let _serviceProviderBuilder: ServiceProviderBuilder;

    private var _queuedLogic: [(HttpProcessor, ServiceProvider) throws -> Void];

    internal init(with httpProcessor: HttpProcessor) {
        _httpProcessor = httpProcessor;
        _serviceProviderBuilder = ServiceProviderBuilder();

        _queuedLogic = [];
    }

    public func WireUp<T>(singleton: @escaping (ServiceProvider) -> T) throws -> App {
        _ = try _serviceProviderBuilder.Register(singleton);

        return self;
    }

    public func WireUp<TController: Controller>(controller: @escaping (ServiceProvider) -> TController) throws -> App {
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

    public func WireUp<TErrorTranslator: ErrorTranslator>(errorTranslator: @escaping (ServiceProvider) -> TErrorTranslator) throws -> App {
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

    public func WireUp<TMiddleware: Middleware>(middleware: @escaping (ServiceProvider) -> TMiddleware) throws -> App {
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

    public func WireUp<TEncoder: Encoder>(encoder: @escaping (ServiceProvider) -> TEncoder) throws -> App {
        _ = try _serviceProviderBuilder.Register(encoder);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let encoder: TEncoder = try serviceProvider.Get() {
                    _ = httpProcessor.WireUp(encoder: encoder);
                }
            }
        );

        return self;
    }

    public func WireUp<TDecoder: Decoder>(decoder: @escaping (ServiceProvider) -> TDecoder) throws -> App {
        _ = try _serviceProviderBuilder.Register(decoder);

        _queuedLogic.append(
            {
                httpProcessor, serviceProvider in

                if let decoder: TDecoder = try serviceProvider.Get() {
                    _ = httpProcessor.WireUp(decoder: decoder);
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

        try _httpProcessor.Start();
    }
}