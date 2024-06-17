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
        
        settingTableView.reloadRows(at: [IndexPath(row: 0, section: 0),
                                         IndexPath(row: 0, section: 1)],
                                    with: .automatic)
    }
}

extension SettingViewController {
    
    private func showWithdrawAlert() {
        
        let withdrawAlert = UIAlertController(title: "탈퇴하기",
                                              message: "탈퇴를 하면 데이터가 모두 초기화됩니다.\n 탈퇴하시겠습니까?",
                                              preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인",
                                          style: .destructive) { _ in
            UserData.data.resetData()
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            let navigationController = UINavigationController(rootViewController: OnboardingViewController())
            sceneDelegate?.window?.rootViewController = navigationController
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .cancel)
        
        withdrawAlert.addAction(confirmAction)
        withdrawAlert.addAction(cancelAction)
        
        self.present(withdrawAlert,
                     animated: false)
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
            
            cell.updateContent()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch SettingList.Section(rawValue: indexPath.section) {
        case .profile:
            navigationController?.pushViewController(ProfileSettingViewController(type: .setting),
                                                     animated: true)
        case .list:
            switch SettingList(rawValue: indexPath.row) {
            case .basket:
                return
                
            case .FAQ:
                return
                
            case .personalAsk:
                return
                
            case .alertSetting:
                return
                
            case .withdraw:
                showWithdrawAlert()
                return
                
            default:
                return
            }
            
        default:
            return
            
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
