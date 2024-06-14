//
//  ProfileSettingViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit
import Combine
import SnapKit

final class ProfileSettingViewController: UIViewController {
    
    private let profileView = ProfileView()
    private let inputNicknameView = InputNicknameView()
    private let completeButton = CapsuledButton(title: "완료")
    
    private var profileViewModel = ProFileViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureHierarchy()
        configureProfileImage()
        setupGestureAndButtonActions()
        configureLayout()
        binding()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureProfileImage()
    }
}

//MARK: - Method

extension ProfileSettingViewController {
    
    private func binding() {
        
        profileViewModel.$imageString
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                profileView.updateProfileImage(named: newValue)
            }.store(in: &cancellables)
        
    }
    
    @objc private func pushSelectProfileVC() {
        navigationController?.pushViewController(SelectProfileViewController(),
                                                 animated: true)
    }
    
    @objc private func popVC() {
        
        UserData.resetData()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeButtonClicked() {
        
        guard let nickname = inputNicknameView.nicknameTextField.text else { return }
        
        if NicknameChecker.resultOfNickname(name: nickname) == NicknameStatus.success {
            profileViewModel.updateNickname(nickname)
            navigationController?.pushViewController(MainViewController(),
                                                     animated: true)
        }
    }
}

//MARK: - Configuration

extension ProfileSettingViewController {
    
    private func configureNavigationBar() {
        
        navigationItem.title = "PROFILE SETTING"
        
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
    
    private func setupGestureAndButtonActions() {
        
        let tapProfileView = UITapGestureRecognizer(target: self,
                                                    action: #selector(pushSelectProfileVC))
        profileView.addGestureRecognizer(tapProfileView)
        
        completeButton.addTarget(self,
                                 action: #selector(completeButtonClicked),
                                 for: .touchUpInside)
    }
    
    private func configureProfileImage() {
        
        guard let imageString = UserData.profileImageString else {
            
            if let randomImageCase = Profile.allCases.randomElement() {
                
                profileViewModel.updateImageString(randomImageCase.rawValue)
            }
            return
        }
        
        profileViewModel.updateImageString(imageString)
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
