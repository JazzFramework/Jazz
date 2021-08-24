import Foundation;

import Server;

import ExampleCommon;
import ExampleServer;

internal final class HelloWorldBackgroundProcess: BackgroundProcess {
    private let _action: GetWeathers;

    internal init(with action: GetWeathers) {
        _action = action;
    }

    public override func Logic() {
        while true {
            sleep(1);

            let weathers: [Weather] = try! _action.Get();

            print("HelloWorldBackgroundProcess \(weathers.count)");
        }
    }
}