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
        
//        viewModel.loadPost { dict in
//            print(dict)
//        }
        
        viewModel.loadData { dict in
            print(dict)
        }
        
    }

}

