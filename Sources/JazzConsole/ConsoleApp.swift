import Foundation;

import JazzCodec;
import JazzCore;
import JazzDependencyInjection;

public final class ConsoleApp: App {
    private var queuedLogic: (ServiceProvider) async throws -> ConsoleAppEntrypoint;
    private var consoleAppEntrypoint: ConsoleAppEntrypoint?;

    internal override init() {
        queuedLogic = { _ in
            throw ConsoleAppBuilderError.invalidBuilderState;
        };
        consoleAppEntrypoint = nil;

        super.init();
    }

    public override final func wireUp<T>(singleton: @escaping (ServiceProvider) async throws -> T) throws -> ConsoleApp {
        _ = try super.wireUp(singleton: singleton);

        return self;
    }

    public override final func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> ConsoleApp {
        _ = try super.wireUp(backgroundProcess: backgroundProcess);

        return self;
    }

    public func wireUp(logic: @escaping (ServiceProvider) async throws -> ConsoleAppEntrypoint) throws -> ConsoleApp {
        queuedLogic = logic;

        return self;
    }

    public final override func initialize(serviceProvider: ServiceProvider) async throws {
        try await super.initialize(serviceProvider: serviceProvider);

        consoleAppEntrypoint = try await queuedLogic(serviceProvider);
    }

    public override final func run() async throws {
        try await super.run();

        if let consoleAppEntrypoint = consoleAppEntrypoint {
            try await consoleAppEntrypoint.start();
        } else {
            print("No entrypoint defined");
        }
    }
}