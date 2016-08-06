/// Will receive call to `onSubscribe(Subscription)` once after passing an instance of `Subscriber` to `Publisher.subscribe(Subscriber)`.
///
/// No further notifications will be received until `Subscription.request(Int)` is called.
///
/// After signaling demand:
/// * One or more invocations of `onNext(AnyObject)` up to the maximum number defined by `Subscription.request(Int)`
/// * Single invocation of `onError(Throwable)` or `Subscriber.onComplete()` which signals a terminal state after which no further events will be sent.
///
/// Demand can be signaled via `Subscription.request(Int)` whenever the `Subscriber` instance is capable of handling more.
public protocol Subscriber {
    
    /// The type of element signaled
    associatedtype ElementType;
    
    /// Invoked after calling `Publisher.subscribe(Subscriber)`.
    ///
    /// No data will start flowing until `Subscription.request(Int)` is invoked.
    ///
    /// It is the responsibility of this `Subscriber` instance to call `Subscription.request(Int)` whenever more data is wanted.
    ///
    /// The `Publisher` will send notifications only in response to `Subscription.request(Int)`.
    ///
    /// - parameter subscription: `Subscription` that allows requesting data via `Subscription.request(Int)`
    func onSubscribe(subscription: Subscription);
    
    /// Data notification sent by the `Publisher` in response to requests to `Subscription.request(Int)`.
    ///
    /// - parameter element: the element signaled
    func onNext(element: ElementType);
    
    /// Failed terminal state.
    ///
    /// No further events will be sent even if `Subscription.request(Int)` is invoked again.
    ///
    /// - parameter error: the error signaled
    func onError(error: Error);
    
    /// Successful terminal state.
    ///
    /// No further events will be sent even if `Subscription.request(Int)` is invoked again.
    func onComplete();
    
}
