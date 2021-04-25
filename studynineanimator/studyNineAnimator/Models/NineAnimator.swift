//
//  NineAnimator.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import Foundation
import Alamofire

typealias NineAnimatorCallback<T> = (T?, Error?) -> ()

enum NineAnimatorError: Error {
    case urlError
    case responseError(String)
    case providerError(String)
}


protocol NineAnimatorAsyncTask {
    func cancel()
}

class NineAnimator: Alamofire.SessionDelegate {
    
    static var `default` = NineAnimator()
    
    let endpoint = "https://arrayanimeapi.vercel.app/api"
    
    let client = URLSession.init(configuration: .default)
    
    var session : Alamofire.Session!
    
    var cache = [NineAnimatePath:String]()
    
    
    
    init() {
        super.init()
        
        var mainAdditionalHeaders = HTTPHeaders.init()
        mainAdditionalHeaders["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.1 Safari/605.1.15"
        mainAdditionalHeaders["Accept-Language"] = "en-us"
        
        let mainSessionConfiguration = URLSessionConfiguration.default
        mainSessionConfiguration.httpShouldSetCookies = true
        mainSessionConfiguration.httpCookieAcceptPolicy = .always
        mainSessionConfiguration.headers = mainAdditionalHeaders
        session = Alamofire.Session(configuration: mainSessionConfiguration, delegate: self)
    }
    
    func removeCache(at path: NineAnimatePath){
        cache.removeValue(forKey: path)
    }
    
    func request(_ path: NineAnimatePath,
                 forceReload: Bool = false,
                 onCompletion: @escaping NineAnimatorCallback<String>) {
        
        
        
        if !forceReload, let cachedData = cache[path] {
            onCompletion(cachedData, nil)
        }
        
        guard let url = URL(string: endpoint + path.value) else {
            onCompletion(nil, NineAnimatorError.urlError)
            return
        }
        
        print(url)
        
        session.request(url).responseString {
            response in
            print(response)
            if case let .failure(error) = response.result {
                debugPrint("Error: Failiure on request: \(error)")
                onCompletion(nil, error)
                return
            }
            
            guard let value = response.value else {
                debugPrint("Error: No data received")
                onCompletion(nil, NineAnimatorError.responseError("no data received"))
                return
            }
            
            //Cache value
            self.cache[path] = value
            onCompletion(value, nil)
        }
    }
}
