import Foundation;

public final class SetCookieBuilder {
    private final var name: String?;
    private final var value: String?;
    private final var domain: String?;
    private final var expires: Date?;
    private final var httpOnly: Bool?;
    private final var maxAge: Int?;
    private final var partitioned: Bool?;
    private final var path: String?;
    private final var sameSite: String?;
    private final var secure: Bool?;

    init() {}

    public final func set(name: String) -> SetCookieBuilder {
        self.name = name;

        return self;
    }

    public final func set(value: String) -> SetCookieBuilder {
        self.value = value;

        return self;
    }

    public final func set(domain: String) -> SetCookieBuilder {
        self.domain = domain;

        return self;
    }

    public final func set(expires: Date) -> SetCookieBuilder {
        self.expires = expires;

        return self;
    }

    public final func set(httpOnly: Bool) -> SetCookieBuilder {
        self.httpOnly = httpOnly;

        return self;
    }

    public final func set(maxAge: Int) -> SetCookieBuilder {
        self.maxAge = maxAge;

        return self;
    }

    public final func set(partitioned: Bool) -> SetCookieBuilder {
        self.partitioned = partitioned;

        return self;
    }

    public final func set(path: String) -> SetCookieBuilder {
        self.path = path;

        return self;
    }

    public final func set(sameSite: String) -> SetCookieBuilder {
        self.sameSite = sameSite;

        return self;
    }

    public final func set(secure: Bool) -> SetCookieBuilder {
        self.secure = secure;

        return self;
    }

    public final func build() -> SetCookie {
        return SetCookie(
            name ?? "",
            value ?? "",
            domain,
            expires,
            httpOnly,
            maxAge,
            partitioned,
            path,
            sameSite,
            secure
        );
    }
}