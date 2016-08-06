/// A `Subscription` represents a one-to-one lifecycle of a `Subscriber` subscribing to a `Publisher`.
///
/// It can only be used once by a single `Subscriber`
///
/// It is used to both signal desire for data and cancel demand (and allow resource cleanup).
public protocol Subscription {
    
    /// No events will be sent by a `Publisher` until demand is signaled via this method.
    ///
    /// It can be called however often and whenever needed-but the outstand cumulative demand must never exceed `Int.max`.
    /// An outstanding cumulative demand of `Int.max` may be treated by the `Published` as "effectively unbounded".
    ///
    /// Whatever has been requested can be sent by the `Publisher` so only signal demand for what can be safely handled.
    ///
    /// A `Publisher` can send less than is requested if the stream ends but
    /// then must emit either `Subscriber.onError(Error)` or `Subscriber.onComplete()`.
    ///
    /// - parameter size: the strictly positive number of elements to requests to the upstream `Publisher`
    func request(size: Int);
    
    /// Request the Publisher to stop sending data and cleanup resources.
    ///
    /// Data may still be sent to meet previously singalled demand after calling cancel as this request is asynchronous.
    func cancel();
    
}
