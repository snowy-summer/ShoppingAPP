//
//  OnboardingViewController.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let backImageView = UIImageView()
    private let startButton = CapsuledButton(title: "시작하기")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        configureHierarchy()
        configureUI()
        configureGestureAndButtonActions()
        configureLayout()
    
    }
    
    @objc private func startButtonClicked() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        let date = formatter.string(from: Date())
        
        UserData.data.signUpDate = date + " 가입"
        navigationController?.pushViewController(ProfileSettingViewController(),
                                                 animated: true)
    }
    
}

extension OnboardingViewController {
    
    private func configureHierarchy() {
        
        view.addSubview(backImageView)
        view.addSubview(titleLabel)
        view.addSubview(startButton)
    }
    
    private func configureUI() {
        
        titleLabel.text = "MeaningOut"
        titleLabel.textAlignment = .center
        titleLabel.textColor = FontType.onboardingTitle.color
        titleLabel.font = FontType.onboardingTitle.font
        
        backImageView.image = .launch
        backImageView.contentMode = .scaleAspectFit
        
    }
    
    private func configureGestureAndButtonActions() {
        
        startButton.addTarget(self,
                              action: #selector(startButtonClicked),
                              for: .touchUpInside)
    }
    
    private func configureLayout() {
        
        backImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backImageView.snp.top).offset(-20)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(backImageView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(44)
            
        }

    }
    
}
