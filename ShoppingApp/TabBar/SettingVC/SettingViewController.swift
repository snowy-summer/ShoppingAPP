//
//  SettingViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    
    private let settingTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        
        configureNavigationBar()
        configureHierarchy()
        configureTableView()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingTableView.reloadRows(at: [IndexPath(row: 0, section: 1)],
                                    with: .automatic)
    }
}

//MARK: - TableViewDelegate, Datasource
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingList.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch SettingList.Section(rawValue: section) {
        case .profile:
            return 1
        case .list:
            return SettingList.allCases.count
        default:
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch SettingList.Section(rawValue: indexPath.section) {
        case .profile:
            return view.frame.height * 0.15
        case .list:
            return view.frame.height * 0.05
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch SettingList.Section(rawValue: indexPath.section) {
        case .profile:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileTableCell.identifier,
                                                           for: indexPath) as? SettingProfileTableCell
            else { return SettingProfileTableCell() }
            
            cell.selectionStyle = .none
            
            return cell
            
        case .list:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingNormalTableCell.identifier,
                                                           for: indexPath) as? SettingNormalTableCell
            else { return SettingNormalTableCell() }
            
            if let data = SettingList(rawValue: indexPath.row) {
                
                cell.selectionStyle = .none
                
                cell.updateContent(type: data)
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
}

//MARK: - Configuration

extension SettingViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.title = "SETTING"
    }
    
    private func configureHierarchy() {
        
        view.addSubview(settingTableView)
    }
    
    private func configureTableView() {
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        settingTableView.register(SettingProfileTableCell.self,
                                  forCellReuseIdentifier: SettingProfileTableCell.identifier)
        settingTableView.register(SettingNormalTableCell.self,
                                  forCellReuseIdentifier: SettingNormalTableCell.identifier)
        
        
    }
    
    private func configureLayout() {
       
        settingTableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}
