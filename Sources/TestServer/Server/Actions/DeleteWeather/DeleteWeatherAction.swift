public protocol DeleteWeatherAction {
    func Delete(weatherId: String) throws;
};