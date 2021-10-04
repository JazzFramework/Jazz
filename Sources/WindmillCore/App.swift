import Foundation;

import WindmillCodec;
import WindmillDependencyInjection;

open class App {
    private var _queuedBackgroundProcesses: [(ServiceProvider) async throws -> Void];
    private let _serviceProviderBuilder: ServiceProviderBuilder;

    public init() {
        _queuedBackgroundProcesses = [];
        _serviceProviderBuilder = ServiceProviderBuilder();
    }

    open func wireUp<T>(singleton: @escaping (ServiceProvider) async throws -> T) throws -> App {
        _ = try _serviceProviderBuilder.register(singleton);

        return self;
    }

    open func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> App {
        _ = try wireUp(singleton: backgroundProcess);

        _queuedBackgroundProcesses.append(
            {
                serviceProvider in

                let backgroundProcess: TBackgroundProcess = try await serviceProvider.fetchType();

                DispatchQueue.global(qos: .background).async {
                    Task {
                        await backgroundProcess.logic();
                    }
                }
            }
        );

        return self;
    }

    open func run() async throws {
        let serviceProvider: ServiceProvider = _serviceProviderBuilder.build();

        try await initialize(serviceProvider: serviceProvider);
    }

    open func initialize(serviceProvider: ServiceProvider) async throws {
        for logic in _queuedBackgroundProcesses {
            try await logic(serviceProvider);
        }
    }
}