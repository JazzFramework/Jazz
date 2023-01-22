import Foundation;

import JazzCodec;
import JazzDependencyInjection;

open class App {
    private var queuedBackgroundProcesses: [(ServiceProvider) async throws -> Void];
    private let serviceProviderBuilder: ServiceProviderBuilder;

    public init() {
        queuedBackgroundProcesses = [];
        serviceProviderBuilder = ServiceProviderBuilder();
    }

    open func wireUp<T>(singleton: @escaping (ServiceProvider) async throws -> T) throws -> App {
        _ = try serviceProviderBuilder.register(singleton);

        return self;
    }

    open func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> App {
        _ = try wireUp(singleton: backgroundProcess);

        queuedBackgroundProcesses.append(
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
        let serviceProvider: ServiceProvider = serviceProviderBuilder.build();

        try await initialize(serviceProvider: serviceProvider);
    }

    open func initialize(serviceProvider: ServiceProvider) async throws {
        for logic in queuedBackgroundProcesses {
            try await logic(serviceProvider);
        }
    }
}