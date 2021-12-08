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
        apiService.getAllProducts(withURL: "https://jsonplaceholder.typicode.com/posts") { dict in
//            self.title.value = dict[9] as Any
            self.subTitle.value = dict[1] as! String
            
        }
    }
}
