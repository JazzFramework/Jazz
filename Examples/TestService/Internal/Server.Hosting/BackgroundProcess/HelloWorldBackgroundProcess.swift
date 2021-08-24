import Foundation;

import Server;

public class HelloWorldBackgroundProcess: BackgroundProcess {
    public override init() {}

    public override func Logic() {
        while true {
            sleep(1);

            print("HelloWorldBackgroundProcess");
        }
    }
}