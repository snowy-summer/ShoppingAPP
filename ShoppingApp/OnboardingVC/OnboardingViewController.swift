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
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureUI()
        configureGestureAndButtonActions()
        configureLayout()
    
    }
    
    @objc private func startButtonClicked() {
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
        titleLabel.textColor = .point
        titleLabel.font = .systemFont(ofSize: 36, weight: .black)
        
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
