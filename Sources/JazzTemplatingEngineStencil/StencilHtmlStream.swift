import JazzServer;

internal final class StencilHtmlStream: StringBackedStream, HtmlStream {
    internal init(html: String) {
        super.init(data: html);
    }
}