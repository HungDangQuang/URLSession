//
//  QueryService.swift
//  URLSession
//
//  Created by QUANG HUNG on 07/Dec/2021.
//

import Foundation
import Combine

enum ApiRouter {
    
   case getPostLink
    
    func get() -> URLRequest {
        switch self{
        case .getPostLink:
            return URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        }
    }
}

class QueryService {
    
    var cancellable: AnyCancellable?
    
    // Ephemeral
    func eConfig()-> URLSessionConfiguration{
        let ephemeralConfiguration = URLSessionConfiguration.ephemeral
        ephemeralConfiguration.allowsCellularAccess = false
        ephemeralConfiguration.waitsForConnectivity = true
        return ephemeralConfiguration
    }
    
    // Default
    func defaultConfig() -> URLSessionConfiguration{
        let defaultConfiguration = URLSessionConfiguration.default
        defaultConfiguration.allowsCellularAccess = false
        defaultConfiguration.waitsForConnectivity = true
        return defaultConfiguration
    }

    
    func getPosts<T: Decodable>(with urlReq: URLRequest, completion:@escaping(Dictionary<String, [T]>)-> Void){
        
        let configuration = eConfig()
        
        let session = URLSession(configuration: configuration)
        cancellable = session.dataTaskPublisher(for: urlReq)
        
            .tryMap({ output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("something went wrong")
                    throw URLError(.badServerResponse)
                }
                return output.data
            })
            .decode(type: [T].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion{
                case .finished:
                    break
                
                case .failure(let err):
                    fatalError(err.localizedDescription)
                }
            }, receiveValue: { posts in
                print(posts.count)
                var dict = [String: [T]]()
                dict["result"] = posts
                completion(dict)
            })
    }
    
    func getPosts<T: Decodable>(with router: ApiRouter, completion:@escaping(Dictionary<String, [T]>)-> Void){
        
        let configuration = eConfig()
        
        let session = URLSession(configuration: configuration)
        cancellable = session.dataTaskPublisher(for: router.get())
        
            .tryMap({ output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("something went wrong")
                    throw URLError(.badServerResponse)
                }
                return output.data
            })
            .decode(type: [T].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion{
                case .finished:
                    break
                
                case .failure(let err):
                    fatalError(err.localizedDescription)
                }
            }, receiveValue: { posts in
                print(posts.count)
                var dict = [String: [T]]()
                dict["result"] = posts
                completion(dict)
            })
    }
    
}
