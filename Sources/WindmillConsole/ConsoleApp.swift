import Foundation;

import WindmillCodec;
import WindmillCore;
import WindmillDependencyInjection;

public final class ConsoleApp: App {
    private var _queuedLogic: (ServiceProvider) async throws -> ConsoleAppEntrypoint;
    private var _consoleAppEntrypoint: ConsoleAppEntrypoint?;

    internal override init() {
        _queuedLogic = { _ in
            throw ConsoleAppBuilderError.invalidBuilderState;
        };
        _consoleAppEntrypoint = nil;

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
        _queuedLogic = logic;

        return self;
    }

    public final override func initialize(serviceProvider: ServiceProvider) async throws {
        try await super.initialize(serviceProvider: serviceProvider);

        _consoleAppEntrypoint = try await _queuedLogic(serviceProvider);
    }

    public override final func run() async throws {
        try await super.run();

        if let consoleAppEntrypoint = _consoleAppEntrypoint {
            try await consoleAppEntrypoint.start();
        } else {
            print("No entrypoint defined");
        }
    }
}