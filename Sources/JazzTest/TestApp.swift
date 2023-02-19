import Foundation;

import JazzCodec;
import JazzConfiguration;
import JazzCore;
import JazzDependencyInjection;

public final class TestApp: App {
    internal override init() {
        super.init();
    }

    public override final func wireUp<T>(
        singleton: @escaping (Configuration, ServiceProvider) async throws -> T
    ) throws -> TestApp {
        _ = try super.wireUp(singleton: singleton);

        return self;
    }

    public override final func wireUp<TBackgroundProcess: BackgroundProcess>(
        backgroundProcess: @escaping (Configuration, ServiceProvider) async throws -> TBackgroundProcess
    ) throws -> TestApp {
        _ = try super.wireUp(backgroundProcess: backgroundProcess);

        return self;
    }

    public final override func initialize(configuration: Configuration, serviceProvider: ServiceProvider) async throws {
        try await super.initialize(configuration: configuration, serviceProvider: serviceProvider);
    }

    public override final func run(configuration: Configuration) async throws {
        try await super.run(configuration: configuration);
    }
}