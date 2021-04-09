//
//  NineAnimator.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import Foundation


enum NineAnimatorError: Error {
    case urlError
    case responseError(String)
}

class NineAnimator  {
    
    static var `default` = NineAnimator()
    
    let endpoint = "https://www1.9anime.to"
    
    let client = URLSession.init(configuration: .default)
    
    var cache = [NineAnimatePath: String]()
    
    func removeCache(at path: NineAnimatePath) {
        cache.removeValue(forKey: path)
    }
    
    func request(_ path: NineAnimatePath,
                 forceReload: Bool = false,
                 onCompletion: @escaping ((String?, Error?) ->())
                ) {
        
        if !forceReload, let cacheData = cache[path] {
            onCompletion(cacheData , nil)
        }
        
        guard let url = URL(string: endpoint + path.value) else {
            onCompletion(nil, NineAnimatorError.urlError)
            return
        }
        
        client.dataTask(with: url) {
            (data, response, error) in
            
            if let error = error {
                onCompletion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                fatalError("NetWord Error: response object is not http response")
            }
            
            guard response.statusCode == 200 else {
                onCompletion(nil, NineAnimatorError.responseError("server returned \(response.statusCode)"))
                return 
            }
            
            guard let data = data else {
                onCompletion(nil, NineAnimatorError.responseError("No content from response"))
                return
            }
            
            onCompletion(String(bytes: data, encoding: .utf8), nil)
        }.resume()
    }
    
    
}
