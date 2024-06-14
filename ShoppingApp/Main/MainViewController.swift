//
//  MainViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        guard let nickname = UserData.nickname else { return }
        navigationItem.title = "\(nickname)'s MEANING OUT"
    }
}

