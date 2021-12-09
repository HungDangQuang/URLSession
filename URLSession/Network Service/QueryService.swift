//
//  QueryService.swift
//  URLSession
//
//  Created by QUANG HUNG on 07/Dec/2021.
//

import Foundation
import Combine

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
    
//    func getAllProducts(withURL url: String,completion:@escaping(Dictionary<Int, Posts>)-> Void){
//
//        let url = URL(string: url)!
//
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap({ output in
//                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
//                    print("something went wrong")
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            })
//            .decode(type: [Posts].self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//            .sink(receiveCompletion: { completion in
//                switch completion{
//                case .finished:
//                    break
//
//                case .failure(let err):
//                    fatalError(err.localizedDescription)
//                }
//            }, receiveValue: { posts in
//                print(posts.count)
//                var dict = [Int: Posts]()
//                for post in posts {
//                    dict[post.id] = post
//                }
//                print(dict)
//                completion(dict)
//            })
//    }
    
    func getAllPosts(withURLRequest url: URLRequest, completion: @escaping(Dictionary<Int, Posts>)-> Void){
        
        let configuration = eConfig()
        
        let session = URLSession(configuration: configuration)
        cancellable = session.dataTaskPublisher(for: url)
        
            .tryMap({ output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("something went wrong")
                    throw URLError(.badServerResponse)
                }
                return output.data
            })
            .decode(type: [Posts].self, decoder: JSONDecoder())
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
                var dict = [Int: Posts]()
                for post in posts {
                    dict[post.id] = post
                }
                completion(dict)
            })
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
    
    
//    func getAmount(withURL url: String, completion:@escaping(Dictionary<Int, Any>)-> Void){
//
//        let url = URL(string: url)!
////        var cancellable : AnyCancellable?
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: [Posts].self, decoder: JSONDecoder())
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//            .sink(receiveValue: { posts in
//                let dict = posts.toDictionary {$0.id}
//                completion(dict)
//            })
//    }
    
}

//extension Array {
//    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
//        var dict = [Key:Element]()
//        for element in self {
//            dict[selectKey(element)] = element
//        }
//        return dict
//    }
//}
