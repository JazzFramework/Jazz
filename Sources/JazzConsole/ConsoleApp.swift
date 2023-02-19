import Foundation;

import JazzCodec;
import JazzConfiguration;
import JazzCore;
import JazzDependencyInjection;

public final class ConsoleApp: App {
    private var queuedLogic: (Configuration, ServiceProvider) async throws -> ConsoleAppEntrypoint;
    private var consoleAppEntrypoint: ConsoleAppEntrypoint?;

    internal override init() {
        queuedLogic = { _, _ in
            throw ConsoleAppBuilderError.invalidBuilderState;
        };
        consoleAppEntrypoint = nil;

        super.init();
    }

    public override final func wireUp<T>(
        singleton: @escaping (Configuration, ServiceProvider) async throws -> T
    ) throws -> ConsoleApp {
        _ = try super.wireUp(singleton: singleton);

        return self;
    }

    public override final func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (Configuration, ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> ConsoleApp {
        _ = try super.wireUp(backgroundProcess: backgroundProcess);

        return self;
    }

    public func wireUp(
        logic: @escaping (Configuration, ServiceProvider) async throws -> ConsoleAppEntrypoint
    ) throws -> ConsoleApp {
        queuedLogic = logic;

        return self;
    }

    public final override func initialize(configuration: Configuration, serviceProvider: ServiceProvider) async throws {
        try await super.initialize(configuration: configuration, serviceProvider: serviceProvider);

        consoleAppEntrypoint = try await queuedLogic(configuration, serviceProvider);
    }

    public override final func run(configuration: Configuration) async throws {
        try await super.run(configuration: configuration);

        if let consoleAppEntrypoint = consoleAppEntrypoint {
            try await consoleAppEntrypoint.start();
        } else {
            print("No entrypoint defined");
        }
    }
}