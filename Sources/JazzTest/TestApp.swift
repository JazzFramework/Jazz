import Foundation;

import JazzCodec;
import JazzCore;
import JazzDependencyInjection;

public final class TestApp: App {
    internal override init() {
        super.init();
    }

    public override final func wireUp<T>(singleton: @escaping (ServiceProvider) async throws -> T) throws -> TestApp {
        _ = try super.wireUp(singleton: singleton);

        return self;
    }

    public override final func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> TestApp {
        _ = try super.wireUp(backgroundProcess: backgroundProcess);

        return self;
    }

    public final override func initialize(serviceProvider: ServiceProvider) async throws {
        try await super.initialize(serviceProvider: serviceProvider);
    }

    public override final func run() async throws {
        try await super.run();
    }
}