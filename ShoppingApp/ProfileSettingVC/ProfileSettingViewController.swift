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
    private let completeButton = UIButton()
    
    private var profileViewModel = ProFileViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    init(type: ProfileSettingViewControllerType) {
        super.init(nibName: nil, bundle: nil)
        profileViewModel.type = type
        configureByType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        configureNavigationBar()
        configureHierarchy()
        configureUI()
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
        navigationController?.pushViewController(SelectProfileViewController(type: profileViewModel.type),
                                                 animated: true)
    }
    
    @objc private func popVC() {
        switch profileViewModel.type {
        case .first:
            UserData.data.resetData()
        case .setting:
            break
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveProfile() {
        
        guard let nickname = inputNicknameView.nicknameTextField.text else { return }
        
        if NicknameChecker.resultOfNickname(name: nickname) == NicknameState.success {
            profileViewModel.updateNickname(nickname)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc private func completeButtonClicked() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        let date = formatter.string(from: Date())
        
        UserData.data.signUpDate = date + " 가입"
        
        guard let nickname = inputNicknameView.nicknameTextField.text else { return }
        
        if NicknameChecker.resultOfNickname(name: nickname) == NicknameState.success {
            profileViewModel.updateNickname(nickname)
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = TabBarController()
            sceneDelegate?.window?.makeKeyAndVisible()
            
        }
    }
}

//MARK: - Configuration

extension ProfileSettingViewController {
    
    private func configureByType() {
        
        switch profileViewModel.type {
        case .setting:
            
            completeButton.isHidden = true
            inputNicknameView.nicknameTextField.text = UserData.data.nickname
            
            let saveViewControllerItem = UIBarButtonItem(title: "저장",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(saveProfile))
            saveViewControllerItem.tintColor = .title
            
            navigationItem.rightBarButtonItem = saveViewControllerItem
        case .first:
            return
        }
        
    }
    
    private func configureNavigationBar() {
        
        navigationItem.title = profileViewModel.type.navigationTitle
        
        
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
    
    private func configureUI() {
        completeButton.configuration = .capsuledButtonWithPointColor(title: "완료")
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
        
        guard let imageString = UserData.data.profileImageString else {
            
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
