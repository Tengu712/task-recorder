import Foundation

extension Published: Encodable
where
    Value: Encodable
{
    public func encode(to encoder: Encoder) throws {
        try Published.extract(from: self).encode(to: encoder)
    }

    private static func extract(from published: Self) -> Value {
        var published = published
        let semaphore = DispatchSemaphore(value: 0)
        var value: Value!
        let _ = published.projectedValue.sink {
            defer { semaphore.signal() }
            value = $0
        }
        semaphore.wait()
        return value
    }
}
