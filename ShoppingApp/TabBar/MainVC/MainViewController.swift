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
    private let recordListHeaderView = RecordListHeaderView()
    
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

//MARK: - Method

extension MainViewController {
    
    private func binding() {
        
        mainViewModel.$list
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self,
                      let newValue = newValue else { return }
                
                if newValue.isEmpty {
                    emptyImageView.isHidden = false
                    listStatusLabel.isHidden = false
                } else {
                    emptyImageView.isHidden = true
                    listStatusLabel.isHidden = true
                }
                recordListTableView.reloadData()
            }.store(in: &cancellables)
    }
    
}

//MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        searchBar.text = .none
        mainViewModel.updateRecordList(text: text)
        
        navigationController?.pushViewController(SearchResultViewController(keyword: text), animated: true)
        
    }
    
}

//MARK: - TableViewDelegate, Datasource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTableViewCell.identifier,
                                                       for: indexPath) as? RecordListTableViewCell else { return RecordListTableViewCell() }
        
        cell.delegate = self
        
        if let data = mainViewModel.list?[indexPath.row] {
            cell.updateContent(text: data.name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        guard let keyword = mainViewModel.list?[indexPath.row].name else { return }
        
        navigationController?.pushViewController(SearchResultViewController(keyword: keyword), animated: true)
    }
    
}

//MARK: - RecordListTableViewCell, RecordListHeaderView Delegate

extension MainViewController: RecordListTableViewCellDelegate,
                              RecordListHeaderViewDelegate {
    
    func deleteListAll() {
        
        mainViewModel.deleteListAll()
    }
    
    func deleteList(at indexPath: IndexPath) {
        
        mainViewModel.deleteRecordList(at: indexPath.row)
    }
    
}

//MARK: - Configuration

extension MainViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.searchController = searchBarController
        configureSearchBarController()
        
        guard let nickname = UserData.data.nickname else { return }
        navigationItem.title = "\(nickname)'s MEANING OUT"
    }
    
    private func configureSearchBarController() {
        
        searchBarController.searchBar.placeholder = "브랜드, 상품 등을 입력하세요"
        searchBarController.searchBar.delegate = self
        
        searchBarController.searchBar.autocorrectionType = .no
        searchBarController.searchBar.spellCheckingType = .no
        searchBarController.searchBar.tintColor = .title
     
    }
    
    private func configureHierarchy() {
        
        view.addSubview(recordListHeaderView)
        view.addSubview(recordListTableView)
        view.addSubview(emptyImageView)
        view.addSubview(listStatusLabel)
    }
    
    private func configureUI() {
        
        recordListHeaderView.delegate = self
        
        emptyImageView.image = UIImage(resource: .empty)
        emptyImageView.contentMode = .scaleAspectFit
        emptyImageView.backgroundColor = .white
        
        listStatusLabel.text = "최근 검색어가 없어요"
        listStatusLabel.font = FontType.boldTitle.font
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
        
        recordListHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        recordListTableView.snp.makeConstraints { make in
            make.top.equalTo(recordListHeaderView.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(recordListHeaderView.snp.top)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        listStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).inset(20)
            make.centerX.equalTo(emptyImageView.snp.centerX)
        }
    }
}
