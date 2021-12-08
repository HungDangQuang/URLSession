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
    func getAllProducts(withURL url: String,completion:@escaping(Dictionary<Int, Any>)-> Void){
        
        let url = URL(string: url)!
       
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
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
                var dict = [Int: String]()
                for post in posts {
                    dict[post.id] = post.title
                }
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
