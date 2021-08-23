import Context
import Flow

import ExampleCommon;
import ExampleServer;

internal class CreateWeatherAction: CreateWeather {
    private let _flow: Flow;
    private let _resultResolver: ContextResolver<FlowContext, WeatherContext>;

    internal init(
        withFlow flow: Flow,
        withResultResolver resultResolver: ContextResolver<FlowContext, WeatherContext>
    ) {
        _flow = flow;
        _resultResolver = resultResolver;
    }

    public func Create(weather: Weather) throws -> Weather {
        let context = FlowContext();

        context.Adopt(subcontext: WeatherContext(weather));

        _ = try _flow.Execute(for: context);

        if let weatherContext: WeatherContext = _resultResolver.Resolve(for: context) {
            return weatherContext.Value;
        }

        throw ContextErrors.notResolveable(reason: "Could not resolve weather context.");
    }
}