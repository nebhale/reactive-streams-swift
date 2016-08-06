/// A `Publisher` is a provider of a potentially unbounded number of sequenced elements, publishing them according to
/// the demand received from its `Subscriber`.
///
/// A `Publisher` can serve multiple `Subscriber`s subscribed `subscribe(Subscriber)` dynamically
/// at various points in time.
public protocol Publisher {
    
    /// The type of subscriber
    associatedtype SubscriberType: Subscriber;
    
    /// Request `Publisher` to start streaming data.
    ///
    /// This is a "factory method" and can be called multiple times, each time starting a new `Subscription`.
    ///
    /// Each `Subscription` will work for only a single `Subscriber`.
    ///
    /// A `Subscriber` should only subscribe once to a single `Publisher`.
    ///
    /// If the `Publisher` rejects the subscription attempt or otherwise fails it will
    /// signal the error via `Subscriber.onError`.
    ///
    /// - parameter subscriber: the `Subscriber` that will consume signals from this `Publisher`
    func subscribe(subscriber: SubscriberType);
    
}
