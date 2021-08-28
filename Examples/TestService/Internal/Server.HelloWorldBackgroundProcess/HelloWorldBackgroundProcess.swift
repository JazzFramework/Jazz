import Foundation;

import Server;

import ExampleCommon;
import ExampleServer;

internal final class HelloWorldBackgroundProcess: BackgroundProcess {
    private let _fetchAction: GetWeathers;
    private let _deleteAction: DeleteWeather;

    internal init(with fetchAction: GetWeathers, with deleteAction: DeleteWeather) {
        _fetchAction = fetchAction;
        _deleteAction = deleteAction;
    }

    public override func Logic() {
        while true {
            sleep(1);

            do {
                let weathers: [Weather] = try _fetchAction.Get();

                print("Hello, The service currently knows of \(weathers.count) weather(s).");

                if weathers.count > 10 {
                    print("The service knows too much about the weather, and will delete all of it's knowledge.");

                    for weather in weathers {
                        try _deleteAction.Delete(weatherId: weather.Id);
                    }
                }
            }
            catch {
                print("An exception occured when trying to get the number of weathers known by the service. We'll continue to try to count because this is example code.");
            }
        }
    }
}