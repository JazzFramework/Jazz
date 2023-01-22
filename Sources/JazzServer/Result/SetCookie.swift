import Foundation;

public final class SetCookie {
    private final let name: String;
    private final let value: String;
    private final let domain: String?;
    private final let expires: Date?;
    private final let httpOnly: Bool?;
    private final let maxAge: Int?;
    private final let partitioned: Bool?;
    private final let path: String?;
    private final let sameSite: String?;
    private final let secure: Bool?;

    internal init(
        _ name: String,
        _ value: String,
        _ domain: String?,
        _ expires: Date?,
        _ httpOnly: Bool?,
        _ maxAge: Int?,
        _ partitioned: Bool?,
        _ path: String?,
        _ sameSite: String?,
        _ secure: Bool?
    ) {
        self.name = name;
        self.value = value;
        self.domain = domain;
        self.expires = expires;
        self.httpOnly = httpOnly;
        self.maxAge = maxAge;
        self.partitioned = partitioned;
        self.path = path;
        self.sameSite = sameSite;
        self.secure = secure;
    }

    public final func getName() -> String {
        return name;
    }

    public final func getValue() -> String {
        return value;
    }

    public final func getDomain() -> String? {
        return domain;
    }

    public final func getExpires() -> Date? {
        return expires;
    }

    public final func getHttpOnly() -> Bool? {
        return httpOnly;
    }

    public final func getMaxAge() -> Int? {
        return maxAge;
    }

    public final func getPartitioned() -> Bool? {
        return partitioned;
    }

    public final func getPath() -> String? {
        return path;
    }

    public final func getSameSite() -> String? {
        return sameSite;
    }

    public final func getSecure() -> Bool? {
        return secure;
    }
}