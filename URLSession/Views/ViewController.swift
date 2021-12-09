//
//  ViewController.swift
//  URLSession
//
//  Created by QUANG HUNG on 07/Dec/2021.
//

import UIKit
import Combine
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    var cancellable: AnyCancellable?
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var cancellable: AnyCancellable?
//        let url = URL(string: "https://youbo.herokuapp.com/post")!
//        //...
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//        .map { $0.data }
//        .decode(type: [Post].self, decoder: JSONDecoder())
//        .replaceError(with: [])
//        .eraseToAnyPublisher()
//        .sink(receiveValue: { posts in
//            print("VC count:\(posts.count)")
//        })
        //...
//        cancellable?.cancel()
//        print("hello")
        
//        apiService.getAmount(withURL: "https://jsonplaceholder.typicode.com/posts") { dict in
//            print(dict)
//        }

//        viewModel.subTitle.bind { data in
//            DispatchQueue.main.async {
//                self.lblTitle.text = data
//            }
//        }
        
//        let apiService = QueryService()
//        apiService.getAllPosts(withURLRequest: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)) { dict in
//            print(dict[1] as Any)
//        }
        
//        apiService.getAllProducts(withURL: "https://jsonplaceholder.typicode.com/posts") { dict in
//            print(dict[1])
//        }
        
        viewModel.subTitle.bind { data in
            DispatchQueue.main.async {
                self.lblTitle.text = data
            }
        }
        
    }

}

