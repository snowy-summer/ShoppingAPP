//
//  MainViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    
    private let searchBarController = UISearchController(searchResultsController: nil)
    private let recordListTableView = UITableView()
    private let emptyImageView = UIImageView()
    private let listStatusLabel = UILabel()
    
    private let mainViewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureHierarchy()
        configureUI()
        configureLayout()
        configureTableView()
        binding()
    }
}

extension MainViewController: UISearchBarDelegate {
    
    private func binding() {
        
        mainViewModel.$list
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                if newValue.isEmpty {
                    emptyImageView.isHidden = false
                    listStatusLabel.isHidden = false
                } else {
                    emptyImageView.isHidden = true
                    listStatusLabel.isHidden = true
                    
                    recordListTableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        mainViewModel.updateRecordList(text: text)
        
    }
    
}

//MARK: - TableViewDelegate, Datasource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTableViewCell.identifier,
                                                       for: indexPath) as? RecordListTableViewCell else { return RecordListTableViewCell() }
        
        let data = mainViewModel.list[indexPath.row]
        cell.updateContent(text: data.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - Configuration

extension MainViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.searchController = searchBarController
        
        searchBarController.searchBar.placeholder = "브랜드 상품등을 입력하세요"
        searchBarController.searchBar.delegate = self
        
        guard let nickname = UserData.nickname else { return }
        navigationItem.title = "\(nickname)'s MEANING OUT"
    }
    
    private func configureHierarchy() {
        
        view.addSubview(recordListTableView)
        view.addSubview(emptyImageView)
        view.addSubview(listStatusLabel)
    }
    
    private func configureUI() {
        
        emptyImageView.image = UIImage(resource: .empty)
        emptyImageView.contentMode = .scaleAspectFit
        
        listStatusLabel.text = "최근 검색어가 없어요"
        listStatusLabel.font = .systemFont(ofSize: 16, weight: .heavy)
    }
    
    private func configureTableView() {
        
        recordListTableView.delegate = self
        recordListTableView.dataSource = self
        recordListTableView.separatorStyle = .none
        recordListTableView.rowHeight = 44
        
        recordListTableView.register(RecordListTableViewCell.self,
                                     forCellReuseIdentifier: RecordListTableViewCell.identifier)
    }
    
    private func configureLayout() {
        
        recordListTableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        listStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).inset(20)
            make.centerX.equalTo(emptyImageView.snp.centerX)
        }
    }
}
