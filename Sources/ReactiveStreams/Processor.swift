/// A Processor represents a processing stage—which is both a `Subscriber`
/// and a `Publisher` and obeys the contracts of both.
public protocol Processor: Subscriber, Publisher {
}
