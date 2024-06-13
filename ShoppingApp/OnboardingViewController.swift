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
    private let startButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
}

extension OnboardingViewController {
    
    private func configureHierarchy() {
        
        view.addSubview(titleLabel)
        view.addSubview(backImageView)
        view.addSubview(startButton)
    }
    
    private func configureUI() {
        
        titleLabel.text = "MeaningOut"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .key
        titleLabel.font = .systemFont(ofSize: 36, weight: .black)
        
        backImageView.image = .launch
        backImageView.contentMode = .scaleAspectFit
        
        startButton.setTitle("시작하기", for: .normal)
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        startButton.configuration = configuration
        startButton.tintColor = .key
        
    }
    
    private func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        backImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalTo(view.snp.directionalHorizontalEdges).inset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        startButton.snp.makeConstraints { make in
            
            make.bottom.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            
        }
       
    }
    
}
