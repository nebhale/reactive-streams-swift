import Foundation
import ReactiveStreams

// `SyncSubscriber` is an implementation of Reactive Streams `Subscriber`,
// it runs synchronously (on the `Publisher`'s thread) and requests one element
// at a time and invokes a user-defined method to process each element.
public protocol SyncSubscriber: class, Subscriber {
    
    var done: Bool { get set }
    
    var subscription: Subscription? { get set }
    
    /// This method is left as an exercise to the reader/extension point
    /// Returns whether more elements are desired or not, and if no more elements are desired
    func whenNext(element: ElementType) -> Bool;
    
}

extension SyncSubscriber where Self: SyncSubscriber {
    
    public func onSubscribe(subscription: Subscription) {
        guard self.subscription != nil else {
            subscription.cancel();
            return
        }
        
        self.subscription = subscription;
        self.subscription?.request(size: 1);
    }
    
    public func onNext(element: Self.ElementType) {
        guard let subscription = subscription else {
            print("Publisher violated the Reactive Streams rule 1.09 signalling onNext prior to onSubscribe.")
            print(Thread.callStackSymbols);
            return
        }
        
        guard !done else { return }
        
        if whenNext(element: element) {
            subscription.request(size: 1);  // Our Subscriber is unbuffered and modest, it requests one element at a time
        } else {
            done();
        }
    }
    
    public func onError(error: Error) {
        guard subscription != nil else { // Technically this check is not needed, since we are expecting `Publisher`s to conform to the spec
            print("Publisher violated the Reactive Streams rule 1.09 signalling onError prior to onSubscribe.");
            print(Thread.callStackSymbols);
            return
        }
        
        // Here we are not allowed to call any methods on the `Subscription` or the `Publisher`, as per rule 2.3
        // And anyway, the `Subscription` is considered to be cancelled if this method gets called, as per rule 2.4
    }
    
    public func onComplete() {
        guard subscription != nil else { // Technically this check is not needed, since we are expecting `Publisher`s to conform to the spec
            print("Publisher violated the Reactive Streams rule 1.09 signalling onComplete prior to onSubscribe.");
            print(Thread.callStackSymbols);
            return
        }
        
        // Here we are not allowed to call any methods on the `Subscription` or the `Publisher`, as per rule 2.3
        // And anyway, the `Subscription` is considered to be cancelled if this method gets called, as per rule 2.4
    }
    
    // Showcases a convenience method to idempotently marking the `Subscriber` as "done", so we don't want to process more elements
    // herefor we also need to cancel our `Subscription`.
    private func done() {
        // On this line we could add a guard against `!done`, but since rule 3.7 says that `Subscription.cancel()` is idempotent, we don't need to.
        done = true; // If we `whenNext` throws an exception, let's consider ourselves done (not accepting more elements)
        
        guard let subscription = subscription else { return }
        
        subscription.cancel();
    }
    
}




