public protocol CookieProcessor {
    func buildCookies(from headers: [String]) -> [Cookie];
    func buildSetCookie(from cookie: SetCookie) -> String;
}