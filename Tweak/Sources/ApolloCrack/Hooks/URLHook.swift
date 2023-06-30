import Jinx
import Foundation

struct ApolloProduct: Encodable {
    let name: String
    let status: String = "ACTIVE_AUTORENEW_ON"
    let subscription_type: String = "LIFETIME"
}

struct URLHook: Hook {
    typealias URLHandler = @Sendable (Data?, URLResponse?, Error?) -> Void
    typealias T = @convention(c) (URLSession, Selector, URLRequest, @escaping (URLHandler)) -> URLSessionDataTask

    let cls: AnyClass? = URLSession.self
    let sel: Selector = sel_registerName("dataTaskWithRequest:completionHandler:")
    let replace: T = { obj, sel, request, handler in
        guard request.url?.absoluteString.contains("/receipt") == true else {
            return orig(obj, sel, request, handler)
        }

        let newHandler: URLHandler = { (_, response, error) in
            let dict: [String: [ApolloProduct]] = [
                "products": [
                    ApolloProduct(name: "ultra"),
                    ApolloProduct(name: "pro"),
                    ApolloProduct(name: "community_icons"),
                    ApolloProduct(name: "spca")
                ]
            ]
            
            let data: Data? = try? JSONEncoder().encode(dict)
            handler(data, response, error)
        }
        
        return orig(obj, sel, request, newHandler)
    }
}
