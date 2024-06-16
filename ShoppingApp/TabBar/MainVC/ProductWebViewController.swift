//
//  ProductWebViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import UIKit
import WebKit

final class ProductWebViewController: UIViewController {
 
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

//MARK: - Configuration

extension ProductWebViewController {
    
    private func configureNavigationBar() {
        
        
    }
    
    private func configureHierarchy() {
        
        view.addSubview(webView)
    }
    
    private func configureLayout() {
        
    }
}
