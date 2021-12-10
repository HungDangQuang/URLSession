//
//  customConfig.swift
//  URLSession
//
//  Created by QUANG HUNG on 10/Dec/2021.
//

import Foundation

class customConfiguration: URLSessionConfiguration {
    var cache: URLCache?
    
    override init(){
        cache = URLCache(memoryCapacity: 0, diskCapacity:100, directory: nil)
        
    }
}
