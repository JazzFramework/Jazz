public protocol RequestProcessor {
    func process(request: RequestContext, result: ResultContext) async;
}