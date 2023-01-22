import Foundation;

import JazzCodec;

public final class ResultContextBuilder {
    private var resultStream: ResultStream?;
    private var transcoderCollection: TranscoderCollection? = nil;
    private var cookieProcessor: CookieProcessor? = nil;
    private var acceptMediaTypes: [MediaType] = [];

    public init() {}

    public final func with(resultStream: ResultStream) -> ResultContextBuilder {
        self.resultStream = resultStream;

        return self;
    }

    public final func with(transcoderCollection: TranscoderCollection) -> ResultContextBuilder {
        self.transcoderCollection = transcoderCollection;

        return self;
    }

    public final func with(cookieProcessor: CookieProcessor) -> ResultContextBuilder {
        self.cookieProcessor = cookieProcessor;

        return self;
    }

    public final func with(acceptMediaTypes: [MediaType]) -> ResultContextBuilder {
        self.acceptMediaTypes = acceptMediaTypes;

        return self;
    }

    public final func build() throws -> ResultContext {
        if
            let resultStream = resultStream,
            let transcoderCollection = transcoderCollection,
            let cookieProcessor = cookieProcessor
        {
            return ResultContext(resultStream, transcoderCollection, cookieProcessor, acceptMediaTypes);
        }

        throw ResultContextErrors.invalidBuilderState;
    }
}