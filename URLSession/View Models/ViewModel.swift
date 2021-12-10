//
//  ViewModel.swift
//  URLSession
//
//  Created by QUANG HUNG on 08/Dec/2021.
//

import Foundation

class ViewModel {
    let apiService = QueryService()
//    let title = Box<Any>((Any).self)
    let subTitle = Box("")
    init(){
       
    }
    func loadPost(completion:@escaping (Dictionary<String, [Posts]>)-> Void){
        apiService.getPosts(with: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!), completion: completion)
    }
    
    func loadData(completion:@escaping (Dictionary<String, [Posts]>)-> Void){
        apiService.getPosts(with: .getPostLink, completion: completion)
    }
    
}
