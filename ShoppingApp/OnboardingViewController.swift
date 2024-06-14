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
        titleLabel.textColor = .key
        titleLabel.font = .systemFont(ofSize: 36, weight: .black)
        
        backImageView.image = .launch
        backImageView.contentMode = .scaleAspectFit
        
        startButton.addTarget(self,
                              action: #selector(startButtonClicked),
                              for: .touchUpInside)
        
    }
    
    private func configureLayout() {
        
        backImageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backImageView.snp.top).offset(20)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        startButton.snp.makeConstraints { make in
            
            make.bottom.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(44)
            
        }

    }
    
}
