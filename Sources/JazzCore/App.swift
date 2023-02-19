import Foundation;

import JazzCodec;
import JazzConfiguration;
import JazzDependencyInjection;

open class App {
    private var queuedBackgroundProcesses: [(Configuration, ServiceProvider) async throws -> Void];
    private let serviceProviderBuilder: ServiceProviderBuilder;

    public init() {
        queuedBackgroundProcesses = [];
        serviceProviderBuilder = ServiceProviderBuilder();
    }

    open func wireUp<T>(singleton: @escaping (Configuration, ServiceProvider) async throws -> T) throws -> App {
        _ = serviceProviderBuilder.register(singleton);

        return self;
    }

    open func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (Configuration, ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> App {
        _ = try wireUp(singleton: backgroundProcess);

        queuedBackgroundProcesses.append(
            {
                _, serviceProvider in

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

    open func run(configuration: Configuration) async throws {
        let serviceProvider: ServiceProvider = serviceProviderBuilder.build(configuration: configuration);

        try await initialize(configuration: configuration, serviceProvider: serviceProvider);
    }

    open func initialize(configuration: Configuration, serviceProvider: ServiceProvider) async throws {
        for logic in queuedBackgroundProcesses {
            try await logic(configuration, serviceProvider);
        }
    }
}