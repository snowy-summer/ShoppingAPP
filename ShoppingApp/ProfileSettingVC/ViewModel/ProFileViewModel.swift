//
//  ProFileViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation
import Combine

final class ProFileViewModel {
    //input output을 enum으로 관리해도 괜찮을 듯.
    @Published var imageString: String? = UserData.data.profileImageString
    @Published var nicknameWhenSaveProfileTapped: String? = UserData.data.nickname
    @Published var nickNameWhenCompleteButtonClicked: String? = nil
    
    var type: ProfileSettingViewControllerType = .create
    
    @Published var outputImageName: String? = nil
    @Published var outputPopViewController: Void? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.$imageString.sink { [weak self] newValue in
            guard let self = self else { return }
            updateImageString(newValue)
            
            outputImageName = newValue
        }.store(in: &cancellables)
        
        self.$nicknameWhenSaveProfileTapped.sink { [weak self] newValue in
            guard let self = self else { return }
            if let newValue = newValue {
                updateNickname(newValue)
            }
        }.store(in: &cancellables)
        
        self.$nickNameWhenCompleteButtonClicked.sink { [weak self] newValue in
            guard let self = self else { return }
            if let newValue = newValue {
                completeButton(newValue)
            }
        }.store(in: &cancellables)
    }
    
    
    private func updateImageString(_ newValue: String?) {
        UserData.data.profileImageString = newValue
    }
    
    private func updateNickname(_ newValue: String) {
        
        if NicknameChecker.resultOfNickname(name: newValue) == NicknameState.success {
            
            outputPopViewController = ()
            
        }
        UserData.data.nickname = newValue
    }
    
    private func completeButton(_ newValue: String) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        let date = formatter.string(from: Date())
        
        UserData.data.signUpDate = date + " 가입"
        
        if NicknameChecker.resultOfNickname(name: newValue) == NicknameState.success {
            
    
            UserData.data.nickname = newValue
        }
    }
}
