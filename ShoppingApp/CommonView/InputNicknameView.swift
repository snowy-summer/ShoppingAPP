//
//  InputNicknameView.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/13/24.
//

import UIKit
import SnapKit

final class InputNicknameView: UIView {

    private(set) var nicknameTextField = UITextField()
    private let lineView = UIView()
    private let explainLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Method

extension InputNicknameView {
    
    @objc private func textFieldDIdChnage() {
        guard let text = nicknameTextField.text else { return }
        if text.trimmingCharacters(in: .whitespaces).isEmpty { return }
        let nicknameStatus = NicknameChecker.resultOfNickname(name: text)
        explainLabel.text = nicknameStatus.script
        explainLabel.textColor = nicknameStatus.color
        lineView.backgroundColor = nicknameStatus.color
        
        return
    }
    
}


//MARK: - Configuration

extension InputNicknameView {
    
    private func configureHierarchy() {
        addSubview(nicknameTextField)
        addSubview(lineView)
        addSubview(explainLabel)

    }
    
    private func configureUI() {
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.font = .systemFont(ofSize: 16,
                                             weight: .bold)
        
        nicknameTextField.addTarget(self,
                                    action: #selector(textFieldDIdChnage),
                                    for: .editingChanged)
        
        lineView.backgroundColor = .icon
    }
    
    private func configureLayout() {
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges).inset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges)
            make.height.equalTo(1)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges).inset(20)
            make.height.equalTo(20)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
