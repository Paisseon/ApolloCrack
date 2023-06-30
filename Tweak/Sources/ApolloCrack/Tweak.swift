import Jinx

struct Tweak {
    static func ctor() {
        DyldHook().hook()
        PaymentHook().hook()
        URLHook().hook()
    }
}

@_cdecl("jinx_entry")
func jinxEntry() {
    Tweak.ctor()
}
