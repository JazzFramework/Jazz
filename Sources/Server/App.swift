import Foundation;

import Codec;
import DependencyInjection;

public class App {
    private let _serviceProviderBuilder: ServiceProviderBuilder;

    internal init() {
        _serviceProviderBuilder = ServiceProviderBuilder();
    }

    open func WireUp<T>(singleton: @escaping (ServiceProvider) throws -> T) throws -> App {
        _ = try _serviceProviderBuilder.Register(singleton);

        return self;
    }


    open func WireUp<TTranscoder: Transcoder>(transcoder: @escaping (ServiceProvider) throws -> TTranscoder) throws -> App {
        _ = try WireUp(singleton: transcoder);

        return self;
    }

    internal func GetServiceProviderBuilder() -> ServiceProviderBuilder {
        return _serviceProviderBuilder;
    }

    open func Run() throws {
        //let serviceProvider: ServiceProvider = _serviceProviderBuilder.Build();
    }
}