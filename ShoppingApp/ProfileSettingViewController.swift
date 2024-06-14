//
//  ProfileSettingViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit
import SnapKit

final class ProfileSettingViewController: UIViewController {
    
    private let profileView = ProfileView()
    private let inputNicknameView = InputNicknameView()
    private let completeButton = CapsuledButton(title: "완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        configureNavigationBar()
        configureHierarchy()
        configureProfileImage()
        configureLayout()
        
    }
}

extension ProfileSettingViewController {
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Configuration

extension ProfileSettingViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.shadowImage = UIImage(resource: .launch)
        
        let popViewControllerItem = UIBarButtonItem(image: UIImage(systemName: IconType.popViewIcon.iconString),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(popVC))
        popViewControllerItem.tintColor = .title
        
        navigationItem.leftBarButtonItem = popViewControllerItem
    }
    
    private func configureHierarchy() {
        
        view.addSubview(profileView)
        view.addSubview(inputNicknameView)
        view.addSubview(completeButton)
    }
    
    private func configureProfileImage() {
        
        guard let imageString = UserData.profileImageString else {
            
            if let randomImageString = Profile.allCases.randomElement() {
                profileView.updateProfileImage(image: UIImage(named: randomImageString.rawValue))
            }
            return
        }
        
        profileView.updateProfileImage(image: UIImage(named: imageString))
    }
    
    private func configureLayout() {
        
        profileView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.height.equalTo(view.snp.width).multipliedBy(0.3)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        inputNicknameView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(inputNicknameView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }

    }
    
}
