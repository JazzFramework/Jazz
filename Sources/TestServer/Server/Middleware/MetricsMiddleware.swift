import Foundation;

import Server;

public class MetricsMiddleware: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        let start: Int = GetCurrentTimeInMilliseconds();

        let result: ResultContext = try next(request);

        let end: Int = GetCurrentTimeInMilliseconds();

        print("[\(request.GetMethod())] \(request.GetUrl()) took: \(end - start)ms");

        return result;
    }

    private func GetCurrentTimeInMilliseconds() -> Int
    {
        let currentDate = Date();

        let since1970 = currentDate.timeIntervalSince1970;

        return Int(since1970 * 1000);
    }
}