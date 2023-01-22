internal final class CookieProcessorImpl: CookieProcessor {
    public final func buildCookies(from headers: [String]) -> [Cookie] {
        var result: [Cookie] = [];

        for header in headers {
            let cookies: [String] = header.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ";");

            for cookie in cookies {
                let cookieParts = cookie.components(separatedBy: "=");

                if cookieParts.count != 2 {
                    continue;
                }

                result.append(
                    Cookie(
                        name: cookieParts[0].trimmingCharacters(in: .whitespacesAndNewlines),
                        value: cookieParts[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                );
            }
        }

        return result;
    }

    public final func buildSetCookie(from cookie: SetCookie) -> String {
        //todo: string builder
        var result: String = "";

        result += cookie.getName();
        result += "=";
        result += cookie.getValue();

        if let domain = cookie.getDomain() {
            result += " domain=\(domain)";
        }
        
        if let expires = cookie.getExpires() {
            //todo: datetime format
            result += " Expires=\(expires)";
        }

        if let httpOnly = cookie.getHttpOnly() {
            if httpOnly {
                result += " HttpOnly";
            }
        }

        if let maxAge = cookie.getMaxAge() {
            result += " Max-Age=\(maxAge)";
        }

        if let partitioned = cookie.getPartitioned() {
            if partitioned {
                result += "Partitioned";
            }
        }

        if let path = cookie.getPath() {
            result += " Path=\(path)";
        }

        if let sameSite = cookie.getSameSite() {
            result += " SameSite=\(sameSite)";
        }

        if let secure = cookie.getSecure() {
            if secure {
                result += " Secure";
            }
        }

        return result;
    }
}