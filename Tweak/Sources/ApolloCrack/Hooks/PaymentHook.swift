import Jinx
import ObjectiveC

struct PaymentHook: Hook {
    typealias T = @convention(c) (AnyObject, Selector) -> Int8

    let cls: AnyClass? = objc_lookUpClass("SKPaymentTransaction")
    let sel: Selector = sel_registerName("transactionState")
    let replace: T = { _, _ in 1 }
}
