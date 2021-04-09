//
//  NineAnimator.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import Foundation
import Alamofire

typealias NineAnimatorCallback<T> = (T?, Error?) -> ()

enum NineAnimatorError: Error {
    case urlError
    case responseError(String)
}

class NineAnimator: Alamofire.SessionDelegate {
    static var `default` = NineAnimator()
    
    let endpoint = "https://www1.9anime.to"
    
    let client = URLSession(configuration: .default)
    
    var session: Alamofire.Session!
    
    var ajaxSession: Alamofire.Session!
    
    var cache = [NineAnimatePath:String]()
    
     init() {
        super.init()
        
        var mainAdditionalHeaders = HTTPHeaders.init()
        mainAdditionalHeaders["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.1 Safari/605.1.15"
        mainAdditionalHeaders["Accept-Language"] = "en-us"
        
        var ajaxAdditionalHeaders = mainAdditionalHeaders
        ajaxAdditionalHeaders["X-Requested-With"] = "XMLHttpRequest"
        ajaxAdditionalHeaders["Accept"] = "application/json, text/javascript, */*; q=0.01"
        
        let mainSessionConfiguration = URLSessionConfiguration.default
        mainSessionConfiguration.httpShouldSetCookies = true
        mainSessionConfiguration.httpCookieAcceptPolicy = .always
        mainSessionConfiguration.headers = mainAdditionalHeaders
        session = Alamofire.Session(configuration: mainSessionConfiguration, delegate: self)
        
        let ajaxSessionConfiguration = URLSessionConfiguration.default
        ajaxSessionConfiguration.httpShouldSetCookies = true
        ajaxSessionConfiguration.httpCookieAcceptPolicy = .always
        ajaxSessionConfiguration.headers = ajaxAdditionalHeaders        
        ajaxSession = Alamofire.Session.init(configuration: ajaxSessionConfiguration, delegate: self)
    }
    
    func removeCache(at path: NineAnimatePath){
        cache.removeValue(forKey: path)
    }
    
    func request(_ path: NineAnimatePath, forceReload: Bool = false, onCompletion: @escaping NineAnimatorCallback<String>) {
        
        print("进入网络请求")
        if !forceReload, let cachedData = cache[path] {
            onCompletion(cachedData, nil)
        }
        
        guard let url = URL(string: endpoint + path.value) else {
            onCompletion(nil, NineAnimatorError.urlError)
            return
        }
        
        print("网络请求的url", url)
        
        AF.request(url).responseString {
            response in
            
            print("查看网络请求结果", response)
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
