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
        fetchData()
    }
    func fetchData(){
        apiService.getAllPosts(withURLRequest: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)) { dict in
            self.subTitle.value = dict[1]!.title
        }
    }
    
    func loadPost(completion:@escaping (Dictionary<String, [Posts]>)-> Void){
        apiService.getPosts(with: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!), completion: completion)
    }
}
