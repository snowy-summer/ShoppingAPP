//
//  ProductWebViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/16/24.
//

import UIKit
import WebKit
import Combine
import SnapKit

final class ProductWebViewController: UIViewController {
 
    private let webView = WKWebView()
    private let viewModel: WebViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(item: Item) {
        self.viewModel = WebViewModel(item: item)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        loadWebView()
    }
    
}

//MARK: - Method

extension ProductWebViewController {
   
    private func loadWebView() {
        
        guard let url = URL(string: viewModel.item.link) else {
            print("잘못된 링크 입니다.")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc private func likeButtonClicked(_ sender: UIBarButtonItem) {
        viewModel.isLicked.toggle()
        let image = viewModel.isLicked ? UIImage(resource: .likeSelected) : UIImage(resource: .likeUnselected)
        navigationItem.rightBarButtonItem?.image = image
        viewModel.changeLike()
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Configuration

extension ProductWebViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.title = viewModel.item.title
        
        let popViewControllerItem = UIBarButtonItem(image: UIImage(systemName: IconType.popViewIcon.iconString),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(popVC))
        
        let image = viewModel.isLicked ? UIImage(resource: .likeSelected) : UIImage(resource: .likeUnselected)
        let likeItem = UIBarButtonItem(image: image,
                                       style: .plain,
                                       target: self,
                                       action: #selector(likeButtonClicked))
        
        popViewControllerItem.tintColor = UIColor.title
        
        navigationItem.leftBarButtonItem = popViewControllerItem
        navigationItem.rightBarButtonItem = likeItem
        
    }
    
    private func configureHierarchy() {
        
        view.addSubview(webView)
    }
    
    private func configureLayout() {
        
        webView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
