//
//  SearchPage.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/26.
//

import Foundation

 
protocol SearchPageDelegate: AnyObject {
    
    func pageIncoming(_: Int, in:SearchPage)
    func noResult(in: SearchPage)
}

class SearchPage {
    
    private(set) var query: String
    private(set) var totalPages: Int?
    weak var delegate: SearchPageDelegate?

    ///availabel adj. 可获得的；可购得的；可找到的；有空的
    var moreAvailable:Bool {
        return totalPages == nil || _results.count < totalPages!
    }
        
    var availablePages: Int {return _results.count}
    
    private var _results: [[AnimeLink]]
    private var _animator: NineAnimator
    private var _lastRequest: NineAnimatorAsyncTask? = nil
    
    init(_ animator: NineAnimator, query: String) {
        self.query = query
        self._animator = animator
        self._results = []
        ///Request thr first page
        more()
    }
    
    deinit {
        _lastRequest?.cancel()
    }
    
    func animes(on page:Int) -> [AnimeLink] {
        return _results[page]
    }
    
    func more()  {
        if moreAvailable && _lastRequest == nil {
            print("信息: 请求页码  \(_results.count + 1) for query \(query)")
            let loadingIndex = _results.count
            let requestURL = NineAnimatePath.search(keyword: query, newPage: availablePages + 1)
            
            print("请求地址~",requestURL)
            _lastRequest = _animator.request(requestURL, onCompletion: {[weak self] response, error in
                
                guard let self = self else { return }
                defer { self._lastRequest = nil }
                
                if self._results.count > loadingIndex {return}
                
                
                guard let response = response else {
                    print("Error: \(error!)")
                    return
                }
                
                do {
                    
                    print("查看search到的数据")
                    
                    if let dataFromString = response.data(using: .utf8, allowLossyConversion: false) {
                        
                        let json = try JSON.init(data: dataFromString)
                        
                        let results = json["results"].arrayValue
                        
                        let animes:[AnimeLink] = try results.compactMap({ (item) -> AnimeLink? in
                            
                            let str:String = item["image"].stringValue
                            let imageLink = URL.init(string: str);
                            let title = item["title"].stringValue
                            let idValue = item["id"].stringValue
                            return AnimeLink.init(title: title, link: idValue, image: imageLink!)
                        })
                        
                        if animes.count > 0 {
                            let newSection = animes.count
                            self._results.append(animes)
                            self.delegate?.pageIncoming(newSection, in: self)
                        } else {
                            print("Info: No matches")
                            self.totalPages = 0
                            self.delegate?.noResult(in: self)
                        }
                    }
                } catch {
                    print("Error when loading more results: \(error)")
                }

            }) as? NineAnimatorAsyncTask
        }
    }
}


  

 
 
extension NineAnimator {
    func search(_ keyword:String) -> SearchPage {
        return SearchPage.init(self, query: keyword)
    }
}
